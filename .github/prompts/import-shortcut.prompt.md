---
mode: agent
description: Reconstruct an existing Apple Shortcut from iPhone as a .jelly source file in this repository.
---

You are importing an existing Apple Shortcut from iPhone into this repository by reconstructing it as a `.jelly` source file. Follow the steps below.

## Step 1 — Get the .shortcut File

Ask the user to export the shortcut from iPhone and place the `.shortcut` file somewhere accessible on their Mac:

- **AirDrop**: Share from Shortcuts app → AirDrop to Mac → accept, then drag into the repo root
- **iCloud Drive**: Save to iCloud from Shortcuts app → download on Mac

Confirm the file path before proceeding.

## Step 2 — Decode the Shortcut

Run `plutil` to convert the binary plist to readable JSON:

```sh
plutil -convert json <file>.shortcut -o /tmp/<file>.json
```

Then read `/tmp/<file>.json`.

## Step 3 — Reconstruct the Jelly Source

Walk the `WFWorkflowActions` array. For each action:

1. **Look up the `WFWorkflowActionIdentifier`** in the Jelly capability index (in the language reference, Section 13). If a native Jelly function exists, use it with the correct parameter labels.

2. **If no native function exists**, generate an `importJSON` block:

   ```jelly
   importJSON({
     "WFWorkflowActionIdentifier": "com.apple.SomeAction",
     "WFWorkflowActionParameters": {
       "ParameterKey": "ParameterValue"
     }
   })
   ```

3. **Reconstruct variables**:
   - Actions that store output to a named variable → use magic variable syntax: `someFunc(...) >> varName`
   - `is.workflow.actions.setvariable` actions → use `var name = value`
   - `is.workflow.actions.getvariable` actions → reference the variable by name directly

4. **Reconstruct control flow**:
   - `is.workflow.actions.conditional` → `if(...) { } else { }`
   - `is.workflow.actions.repeat.count` → `repeat(n) { }`
   - `is.workflow.actions.repeat.each` → `repeatEach(list) { }`
   - `is.workflow.actions.choosefrommenu` → `menu("...", [...]) { case(...): ... }`

## Step 4 — Gather Metadata

Ask the user for:

1. **Category** — `productivity`, `media`, or `utilities`
2. **Color** — valid `#Color` value (refer to language reference Section 11)
3. **Icon** — valid `#Icon` value (refer to language reference Section 11)
4. **Brief description** — one sentence for the index

Derive the kebab-case filename from the shortcut's display name (found in `WFWorkflowName` in the JSON).

## Step 5 — Scaffold the File

Create the file at `{category}/{kebab-case-name}.jelly` with:

- Correct `import` statements (derived from the actions found)
- `#Color` and `#Icon` metadata
- The reconstructed action sequence
- A header comment with the shortcut name and description

## Step 6 — Register in the Index

Append a row to `docs/shortcuts-index.md` in the **All Shortcuts** table.

## Step 7 — Warn and Verify

Tell the user:

> "Reconstruction complete. Magic variable chains and complex type coercions may need hand-tuning — the reconstructed source is a best-effort translation. Run `/compile-export` to verify it compiles, then test the shortcut on-device before relying on it."

## Rules

- Never mention the paid Jellycuts app or Jellycuts Bridge.
- If an action identifier is unrecognized, always fall back to `importJSON` — never omit the action or hallucinate a function name.
- After reconstruction, always direct the user to run `/compile-export` to validate.
- The original `.shortcut` file can be deleted from the repo root after scaffolding is complete — it is binary and not useful as source.
