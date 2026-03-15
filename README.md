# Jelly Shortcuts

A personal Apple Shortcuts library written in [Jelly](https://github.com/OpenJelly/Open-Jellycore), compiled to `.shortcut` files using the open-source [`jelly` CLI](https://github.com/OpenJelly/Open-Jellycore).

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

**Compile and sign a single shortcut:**

```sh
~/bin/jelly utilities/flashlight-blink.jelly --export --out build/unsigned/flashlight-blink.shortcut
shortcuts sign --mode anyone --input build/unsigned/flashlight-blink.shortcut --output build/flashlight-blink.shortcut
```

**Compile and sign all shortcuts:**

```sh
find . -name "*.jelly" -not -path "./.git/*" | while read f; do
  name=$(basename "${f%.jelly}")
  ~/bin/jelly "$f" --export --out "build/unsigned/$name.shortcut"
  shortcuts sign --mode anyone --input "build/unsigned/$name.shortcut" --output "build/$name.shortcut"
done
```

Signed `.shortcut` files are written to `build/` (gitignored). Transfer them to your iPhone via AirDrop or iCloud Drive, then open in the Shortcuts app. Signing requires an active iCloud login and internet connection.

In VS Code, press `⌘⇧B` to run the **Compile & Sign Current File** build task.

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

Reusable Copilot prompts live in `.github/prompts/`. Each is a thin shim — the full logic lives in `.agent/skills/`.

| Prompt | Skill Source | Purpose |
|---|---|---|
| `/new-shortcut` | `.agent/skills/new-shortcut/` | Scaffold a new `.jelly` file and register it in the index |
| `/compile-export` | `.agent/skills/compile-export/` | Compile and sign the current file |
| `/fix-compiler-error` | `.agent/skills/fix-compiler-error/` | Diagnose and fix a `jelly` compiler error |
| `/deploy-to-device` | `.agent/skills/deploy-to-device/` | Transfer a signed shortcut to iPhone |
| `/import-shortcut` | `.agent/skills/import-shortcut/` | Reconstruct a `.shortcut` from iPhone as a `.jelly` source file |
| `/add-menu` | `.agent/skills/add-menu/` | Insert a `menu/case` block with correct syntax |
| `/debug-shortcut` | `.agent/skills/debug-shortcut/` | Instrument a script with `quicklook()` calls for debugging |

---

## Agent Integration

This repository is **agent-agnostic**. Logic is not coupled to any specific IDE.

| Layer | Path | Role |
|---|---|---|
| **Global brain** | `AGENTS.md` | Entry point for any agent — architecture map, how-to-act rules |
| **Source of truth** | `.agent/` | All coding rules and skill workflows live here |
| **Build tools** | `Makefile` | Executable CLI targets any agent can invoke via terminal |
| **VS Code / Copilot** | `.github/` | Shim — activates Copilot context, delegates to `.agent/` |
| **Cursor** | `.cursor/rules/jelly.mdc` | Shim — activates Cursor rules on `.jelly` files, delegates to `.agent/` |

> **For agents:** Read `AGENTS.md` first. Never add logic to shim files.
