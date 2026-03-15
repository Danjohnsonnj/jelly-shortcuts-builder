---
name: add-menu
description: Insert a menu/case block into the current Jelly shortcut with correct syntax.
---

You are inserting a `menu` block into a Jelly shortcut in this repository. Follow the steps below.

## Step 1 — Gather Requirements

Ask the user for:

1. **Prompt text** — the question or instruction shown to the user in the menu (e.g. `"What would you like to do?"`).
2. **Options** — a list of string labels for each menu item (e.g. `["Option A", "Option B", "Option C"]`).
3. **Where to insert** — at the end of the file, or after a specific variable/line (ask the user to describe the location if not at the end).

## Step 2 — Read the Current File

Read the currently open `.jelly` file to understand its context and find the correct insertion point.

## Step 3 — Generate the Menu Block

Use this exact syntax:

```jelly
menu("{prompt text}", ["{Option A}", "{Option B}", "{Option C}"]) {
    case("{Option A}"):
        // TODO: handle Option A

    case("{Option B}"):
        // TODO: handle Option B

    case("{Option C}"):
        // TODO: handle Option C
}
```

## Step 4 — Insert the Block

Insert the generated `menu` block at the requested location in the file.

## Rules and Gotchas

- **Case labels must be hardcoded string literals.** You cannot use variables or magic variables as `case` identifiers — the value must match the option string exactly.
- The option array in `menu(...)` and the `case(...)` labels must use identical strings. Any mismatch will cause the case to never match.
- `menu` blocks can be nested, but keep nesting shallow for readability.
- Each `case` block must end before the next `case` begins — there is no fall-through.
- After inserting, remind the user to replace the `// TODO` comments with actual shortcut logic.
