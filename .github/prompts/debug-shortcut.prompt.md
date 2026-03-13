---
mode: agent
description: Instrument a Jelly shortcut with quicklook() calls for debugging, then clean them up before export.
---

You are instrumenting a Jelly shortcut with `quicklook()` calls to make variable values visible during debugging. Follow the steps below.

## Step 1 — Read the Current File

Read the currently open `.jelly` file in its entirety.

## Step 2 — Identify Variables

Find all variable declarations in the file. Look for:

- `var name = ...` — standard variable declarations
- `... >> name` — pipeline capture (assigns result to a named variable)
- `ShortcutInput` — the implicit input variable

List the variable names you found to the user and ask which ones they want to inspect. Alternatively, offer to instrument all of them.

## Step 3 — Insert quicklook() Calls

After each selected variable declaration, insert a `quicklook(input: varName)` call:

```jelly
var result = calculate(input: "2 + 2")
quicklook(input: result)
```

For pipeline captures:

```jelly
someValue >> capturedVar
quicklook(input: capturedVar)
```

For `ShortcutInput`, insert after the nil check:

```jelly
if(ShortcutInput == nil) {
    exit()
}
quicklook(input: ShortcutInput)
```

## Step 4 — Confirm Insertions

Show the user the modified file (or a diff of the changes) and confirm the insertions look correct.

## Step 5 — Cleanup Reminder

**Important:** After debugging, all `quicklook()` calls must be removed before exporting the final `.shortcut` file. Leaving them in will cause the shortcut to pause and display popups during normal use.

When the user indicates they are done debugging, offer to remove all `quicklook(input: ...)` lines from the file automatically.

## Rules

- Only insert `quicklook(input: varName)` — do not use bare `quicklook()` without the `input:` label.
- Do not insert quicklooks inside `if` or `repeat` blocks unless the user specifically asks — they may not execute on every run.
- Do not modify any other logic in the file — this prompt is purely additive.
- Always warn the user to remove quicklooks before export.
