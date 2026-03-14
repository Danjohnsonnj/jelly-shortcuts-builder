---
agent: agent
description: Scaffold a new Jelly shortcut file in the correct category folder and register it in the shortcuts index.
---

You are creating a new Apple Shortcut in this Jelly Shortcuts repository. Follow the steps below in order.

## Step 1 — Gather Requirements

Ask the user for the following (collect all answers before proceeding):

1. **Shortcut name** — display name (e.g. "Resize Image"). This becomes the kebab-case filename.
2. **Category** — choose from: `productivity`, `media`, `utilities`
3. **Color** — valid `#Color` value (e.g. `red`, `blue`, `green`, `yellow`, `orange`, `purple`, `pink`, `teal`, `indigo`, `gray`). Refer to the Jelly language reference for the full list.
4. **Icon** — valid `#Icon` value (e.g. `photo`, `clock`, `star`, `list`, `camera`). Refer to the Jelly language reference for the full list.
5. **Does it take Shortcut Input?** — yes or no.
6. **Brief description** — one sentence describing what the shortcut does (used in the index).
7. **Inputs** — what the shortcut expects as input, or "none".
8. **Outputs** — what the shortcut returns, or "none".
9. **Libraries** — any libraries beyond `import Shortcuts` (e.g. `import DataJar`), or "none".

## Step 2 — Check for Duplicates

Before creating the file, read `docs/shortcuts-index.md` and check whether a shortcut with the same or very similar functionality already exists. If one does, inform the user and suggest using `runShortcut(name: "...")` to compose with it instead of duplicating logic.

## Step 3 — Scaffold the File

Create the file at: `{category}/{kebab-case-name}.jelly`

Use the following template:

```jelly
import Shortcuts
#Color: {color}
#Icon: {icon}

// {Shortcut Name}
// {brief description}
```

If the shortcut takes input, add the nil check immediately after metadata:

```jelly
if(ShortcutInput == nil) {
    exit()
}
```

Add a placeholder comment block where the shortcut logic will go:

```jelly
// TODO: implement shortcut logic here
```

## Step 4 — Update the Shortcuts Index

Append a new row to `docs/shortcuts-index.md` in the **All Shortcuts** table with the following columns:

| Name | File | Description | Inputs | Outputs | Libraries |
| ---- | ---- | ----------- | ------ | ------- | --------- |

Use the information collected in Step 1.

If the shortcut is designed to be called by other shortcuts via `runShortcut()`, also add it to the **Composable Shortcuts** section.

## Rules

- Filename must be kebab-case, all lowercase, `.jelly` extension.
- Never create files in the repo root — always use a category subfolder.
- `import Shortcuts` must always be the first line.
- `#Color` and `#Icon` are required on every script.
- The nil check on `ShortcutInput` is required for any shortcut that takes input.
