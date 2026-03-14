# Jellycuts

A personal Apple Shortcuts library written in [Jelly](https://docs.jellycuts.com/), compiled to `.shortcut` files using the open-source [`jelly` CLI](https://github.com/OpenJelly/Open-Jellycore).

---

## Prerequisites

Install the `jelly` compiler via Homebrew:

```sh
brew tap actuallytaylor/formulae
brew install jelly
```

Verify the install:

```sh
jelly --help
```

---

## Usage

**Compile a single shortcut:**

```sh
jelly utilities/flashlight-blink.jelly --export --out ./build/
```

**Compile all shortcuts:**

```sh
find . -name "*.jelly" -exec jelly {} --export --out ./build/ \;
```

Compiled `.shortcut` files are written to `build/` (gitignored). Transfer them to your iPhone via AirDrop or iCloud Drive, then open in the Shortcuts app.

In VS Code, press `⌘⇧B` to run the **Compile Current File** build task.

---

## Folder Structure

```
productivity/    — task management, notes, reminders, calendar
media/           — photos, video, music, podcasts
utilities/       — system tools, calculations, text processing, data lookups
build/           — compiled .shortcut output (gitignored)
docs/            — shortcut catalog and project documentation
```

- One shortcut per file
- Filenames are kebab-case: `my-shortcut-name.jelly`

---

## Shortcut Catalog

See [docs/shortcuts-index.md](docs/shortcuts-index.md) for a full list of shortcuts in this repo, including descriptions, inputs, outputs, and library dependencies.

---

## Agent Prompts

Reusable Copilot prompts live in `.github/prompts/`:

| Prompt | Purpose |
|---|---|
| `/new-shortcut` | Scaffold a new `.jelly` file and register it in the index |
| `/compile-export` | Compile the current file and surface any errors |
| `/fix-compiler-error` | Diagnose and fix a `jelly` compiler error |
| `/deploy-to-device` | Transfer a compiled shortcut to iPhone |
| `/import-shortcut` | Reconstruct a `.shortcut` file from iPhone as a `.jelly` source file |
| `/add-menu` | Insert a `menu/case` block with correct syntax |
| `/debug-shortcut` | Instrument a script with `quicklook()` calls for debugging |
