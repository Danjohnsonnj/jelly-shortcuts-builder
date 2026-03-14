# Jelly Shortcuts Repo — Copilot Instructions

This repository is a personal Apple Shortcuts library written in **Jelly**, the text-based language compiled by the open-source [jelly CLI](https://github.com/OpenJelly/Open-Jellycore). Every file in this repo is a `.jelly` source file that compiles to an Apple Shortcut.

---

## Folder Structure

Shortcuts are organized by category. Always place new scripts in the appropriate subdirectory, for example:

```
productivity/    — task management, notes, reminders, calendar
media/           — photos, video, music, podcasts
utilities/       — system tools, calculations, text processing, data lookups
```

- Filenames are **kebab-case**: `my-shortcut-name.jelly`
- One shortcut per file
- Do not create flat files in the root; always use a category subfolder, creating a new folder, if necessary.

---

## Project-Wide Coding Rules

Every `.jelly` file in this repo must follow these conventions:

1. **First line is always `import Shortcuts`** — no exceptions.
2. **Metadata is required on every script.** Include `#Color` and `#Icon` at the top (after imports). Refer to the Jelly language reference for valid color and icon values.
3. **Early-exit nil check on input.** If a shortcut expects `Shortcut Input`, the second block after metadata must check for nil and call `exit()` if the input is missing:

   ```jelly
   import Shortcuts
   #Color: red
   #Icon: bookmark

   if(ShortcutInput == nil) {
       exit()
   }
   ```

4. **Use Data Jar for any cross-run persistence.** Do not use `setVariable`/`getVariable` for data that needs to survive between shortcut runs. Import the Data Jar library when persistence is needed.
5. **Compose across shortcuts with `runShortcut(name: "...")`** rather than duplicating logic. Check `docs/shortcuts-index.md` before building a new shortcut — the functionality may already exist.
6. **No magic variables in `case` labels.** Menu case labels must be hardcoded string literals. Variables cannot be used as case identifiers.

---

## Resources

| Resource                     | Location                                                                                    |
| ---------------------------- | ------------------------------------------------------------------------------------------- |
| **Jelly Language Reference** | `~/.github/instructions/jelly.instructions.md` (auto-loads on `.jelly` files via `applyTo`) |
| **Shortcut Catalog**         | `docs/shortcuts-index.md`                                                                   |
| **Reusable Agent Prompts**   | `.github/prompts/`                                                                          |
| **Build Setup & CLI Usage**  | `README.md`                                                                                 |

---

## Agent Instructions

- **Before creating a new shortcut**, check `docs/shortcuts-index.md` to confirm the shortcut does not already exist. If a similar one exists, prefer extending it via `runShortcut()` composition rather than duplicating code.
- **After creating a new shortcut**, append a row to `docs/shortcuts-index.md`. Use the `/new-shortcut` prompt (`.github/prompts/new-shortcut.prompt.md`) for a guided scaffolding workflow that handles this automatically.
- **When inserting a menu block**, use the `/add-menu` prompt to ensure correct `menu/case` syntax.
- **When debugging**, use the `/debug-shortcut` prompt to instrument a file with `quicklook()` calls. Always remove them before compiling the final export.
- **To compile and export a shortcut**, use the `/compile-export` prompt — it runs `jelly` in the terminal and surfaces any errors.
- **To transfer a compiled shortcut to iPhone**, use the `/deploy-to-device` prompt.
- **To import an existing shortcut from iPhone into this repo**, use the `/import-shortcut` prompt.
- The Jelly language reference (`jelly.instructions.md`) loads automatically when a `.jelly` file is open. If you need library-specific docs not covered in the reference, fetch them from the URL listed in the "Further Documentation" section of that file.
