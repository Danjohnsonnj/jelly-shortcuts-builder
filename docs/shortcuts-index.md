# Shortcuts Index

This file is the canonical catalog of all Apple Shortcuts in this repository. It is read by the agent before creating any new shortcut to avoid duplication.

> **Agent instruction:** Before creating a new shortcut, scan this file for existing shortcuts with the same or similar purpose. If one exists, prefer composing with it via `runShortcut(name: "...")` rather than duplicating logic. After creating a new shortcut, append a row to the table below. Use the `/new-shortcut` prompt to handle this automatically.

---

## All Shortcuts

| Name | File | Description | Inputs | Outputs | Libraries |
|---|---|---|---|---|---|

*No shortcuts yet. Use the `/new-shortcut` prompt to add one.*

---

## Composable Shortcuts

These shortcuts are designed to be called by other shortcuts via `runShortcut(name: "...")`. They accept a defined input and return a defined output.

| Name | File | Description | Inputs | Outputs |
|---|---|---|---|---|

*None yet.*

---

## Maintenance

- New entries are added automatically when using the `/new-shortcut` prompt.
- To add an entry manually, append a row to the appropriate table above.
- Keep descriptions to one sentence.
- For the **Libraries** column, list any imports beyond `import Shortcuts` (e.g. `DataJar`), or write `—` if none.
- For **Inputs** and **Outputs**, write `none` if the shortcut takes no input or returns no output.
