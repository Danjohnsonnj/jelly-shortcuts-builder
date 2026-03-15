---
name: jelly-syntax
description: Jelly language coding rules, conventions, and project standards. Source of truth for all agents working in this repository.
---

# Jelly Syntax Rules

> This is the **source of truth** for all agents working in this repository.
> IDE-specific files (`.github/copilot-instructions.md`, `.cursor/rules/jelly.mdc`) are shims that point here.

---

## Folder Structure

Shortcuts are organized by category. Always place new scripts in the appropriate subdirectory:

```
productivity/    — task management, notes, reminders, calendar
media/           — photos, video, music, podcasts
utilities/       — system tools, calculations, text processing, data lookups
```

- Filenames are **kebab-case**: `my-shortcut-name.jelly`
- One shortcut per file
- Do not create flat files in the repo root; always use a category subfolder, creating a new one if necessary.

---

## Project-Wide Coding Rules

Every `.jelly` file in this repo must follow these conventions:

1. **First line is always `import Shortcuts`** — no exceptions.
2. **Metadata is required on every script.** Include `#Color` and `#Icon` at the top (after imports). Refer to `~/.github/instructions/jelly.instructions.md` for valid color and icon values.
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

## Build & Sign Requirements

Unsigned `.shortcut` files are rejected on import by iOS/macOS. Every compiled shortcut must be signed before deployment.

| Step | `make` command | Manual command |
|------|---------------|----------------|
| Compile | `make build FILE=<path>` | `~/bin/jelly <file>.jelly --export --out build/unsigned/<name>.shortcut` |
| Sign | `make sign FILE=<path>` | `shortcuts sign --mode anyone --input build/unsigned/<name>.shortcut --output build/<name>.shortcut` |
| Both | `make deploy FILE=<path>` | — |
| All files | `make build-all` | — |
| Decode a .shortcut | `make decompile FILE=<path>` | `plutil -convert json <file>.shortcut -o /tmp/<name>.json` |

**Signing requirements:**
- The Mac must be signed into an active iCloud account.
- An internet connection is required (Apple validates the file hash server-side).
- Pre-flight check: `shortcuts list | head -3` must return your library.

---

## Resources

| Resource | Location |
|---|---|
| **Jelly Language Reference** | `~/.github/instructions/jelly.instructions.md` (auto-loads on `.jelly` files) |
| **Shortcut Catalog** | `docs/shortcuts-index.md` |
| **Agent Skills** | `.agent/skills/` |
| **Build Tools** | `Makefile` |
| **Open-Jellycore (CLI + language)** | https://github.com/OpenJelly/Open-Jellycore |

---

## Agent Workflow Rules

- **Before creating a new shortcut**: check `docs/shortcuts-index.md` for duplicates. Follow `.agent/skills/new-shortcut/SKILL.md`.
- **After creating a new shortcut**: append a row to `docs/shortcuts-index.md`.
- **When inserting a menu block**: follow `.agent/skills/add-menu/SKILL.md` for correct `menu/case` syntax.
- **When debugging**: follow `.agent/skills/debug-shortcut/SKILL.md`. Remove all `quicklook()` calls before compiling for export.
- **To compile and sign**: follow `.agent/skills/compile-export/SKILL.md` or run `make deploy FILE=<path>`.
- **To transfer to iPhone**: follow `.agent/skills/deploy-to-device/SKILL.md`.
- **To import an existing shortcut from iPhone**: follow `.agent/skills/import-shortcut/SKILL.md`.
