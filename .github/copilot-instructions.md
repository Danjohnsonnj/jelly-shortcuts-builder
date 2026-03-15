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
| **Agent Architecture**       | `AGENTS.md` — read this first                                                               |
| **Jelly Coding Rules**       | `.agent/rules/jelly-syntax.md` — source of truth                                            |
| **Jelly Language Reference** | `~/.github/instructions/jelly.instructions.md` (auto-loads on `.jelly` files via `applyTo`) |
| **Shortcut Catalog**         | `docs/shortcuts-index.md`                                                                   |
| **Agent Skills**             | `.agent/skills/`                                                                            |
| **Build Tools**              | `Makefile`                                                                                  |
| **Build Setup & CLI Usage**  | `README.md`                                                                                 |

---

## Agent Instructions

This repository uses an **agent-agnostic** architecture. All logic lives in `.agent/`. The files in `.github/prompts/` are thin shims that delegate to `.agent/skills/`.

- **Read `AGENTS.md` first** — it maps the full repository architecture and explains how to act.
- **For coding rules**, read `.agent/rules/jelly-syntax.md`.
- **Before creating a new shortcut**, check `docs/shortcuts-index.md` for duplicates, then follow `.agent/skills/new-shortcut/SKILL.md`.
- **After creating a new shortcut**, append a row to `docs/shortcuts-index.md`.
- **When inserting a menu block**, use `/add-menu` → delegates to `.agent/skills/add-menu/SKILL.md`.
- **When debugging**, use `/debug-shortcut` → delegates to `.agent/skills/debug-shortcut/SKILL.md`. Remove all `quicklook()` calls before compiling.
- **To compile and sign**, use `/compile-export` or run `make deploy FILE=<path>`.
- **To transfer to iPhone**, use `/deploy-to-device`.
- **To import an existing shortcut from iPhone**, use `/import-shortcut`.
- The Jelly language reference (`jelly.instructions.md`) loads automatically when a `.jelly` file is open. If you need library-specific docs not covered in the reference, fetch them from the URL listed in the "Further Documentation" section of that file.
