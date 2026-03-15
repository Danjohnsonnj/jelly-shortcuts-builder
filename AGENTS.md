# AGENTS.md — Jelly Shortcuts Repository

> **Read this file first.** It is the entry point for any AI agent working in this repository, regardless of IDE or platform.

---

## What This Repository Does

This is a personal Apple Shortcuts library written in **Jelly** — a text-based language that compiles to `.shortcut` binary files executed natively by Apple's Shortcuts app on iPhone, iPad, and Mac.

The compiler is the open-source [`jelly` CLI](https://github.com/OpenJelly/Open-Jellycore) (Open-Jellycore project). There is no dependency on any paid app.

**The full write → compile → sign → deploy loop:**

1. Write a `.jelly` script in `productivity/`, `media/`, or `utilities/`
2. Compile + sign in one step: `make deploy FILE=<path/to/file.jelly>`
3. Transfer `build/<name>.shortcut` to iPhone via AirDrop or iCloud Drive
4. Open the file on iPhone — Shortcuts imports it automatically

---

## Repository Architecture

This repository uses an **agent-agnostic** architecture. Logic lives in one place (`.agent/`). IDE-specific folders are lightweight shims that point back to it.

```
├── AGENTS.md                    ← You are here. Read this first.
├── Makefile                     ← All executable tools (build, sign, deploy, decompile)
├── README.md                    ← Human-readable setup guide
│
├── .agent/                      ← SOURCE OF TRUTH for all agent logic
│   ├── rules/
│   │   └── jelly-syntax.md      ← Full Jelly coding rules and conventions
│   └── skills/
│       ├── new-shortcut/        ← Scaffold a new .jelly file
│       │   ├── SKILL.md
│       │   └── template.jelly
│       ├── compile-export/      ← Compile and sign a shortcut
│       ├── fix-compiler-error/  ← Diagnose and fix compiler errors
│       ├── deploy-to-device/    ← Transfer a shortcut to iPhone
│       ├── import-shortcut/     ← Reconstruct a .shortcut as .jelly
│       ├── add-menu/            ← Insert a menu/case block
│       ├── debug-shortcut/      ← Instrument with quicklook()
│       └── onboard/             ← First-run agent boot sequence
│
├── .github/
│   ├── copilot-instructions.md  ← Copilot shim → points to .agent/
│   └── prompts/                 ← Copilot prompt shims → delegate to .agent/skills/
│
├── .cursor/
│   └── rules/
│       └── jelly.mdc            ← Cursor shim → points to .agent/rules/
│
├── productivity/                ← Shortcut source files (.jelly)
├── media/
├── utilities/
├── build/                       ← Signed output (gitignored)
│   └── unsigned/                ← Raw compiler output (gitignored)
└── docs/
    └── shortcuts-index.md       ← Catalog of all shortcuts in this repo
```

---

## Agent: How to Act

### When writing or editing a `.jelly` file
Read `.agent/rules/jelly-syntax.md` for the full rule set. Key constraints:
- `import Shortcuts` must be line 1
- `#Color` and `#Icon` metadata required on every script
- Nil-check `ShortcutInput` at the top if the shortcut takes input
- No variables in `case` labels — hardcoded string literals only

### When creating a new shortcut
Follow `.agent/skills/new-shortcut/SKILL.md`. Always check `docs/shortcuts-index.md` for duplicates first.

### When compiling
Run `make deploy FILE=<path>` or follow `.agent/skills/compile-export/SKILL.md`. Signing via `/usr/bin/shortcuts` is mandatory — unsigned files are rejected on import by iOS/macOS.

### When fixing a compiler error
Follow `.agent/skills/fix-compiler-error/SKILL.md`.

### When deploying to iPhone
Follow `.agent/skills/deploy-to-device/SKILL.md`.

### When importing an existing shortcut from iPhone
Follow `.agent/skills/import-shortcut/SKILL.md`.

---

## Fetching External Documentation

Use the `fetch` MCP tool to retrieve live documentation when needed.

- **Open-Jellycore (language + CLI):** `https://github.com/OpenJelly/Open-Jellycore`
- **Jelly language reference:** `~/.github/instructions/jelly.instructions.md` — auto-loads in VS Code on any `.jelly` file via `applyTo`
- **Apple Shortcuts CLI:** run `shortcuts sign --help` or `shortcuts --help`

If you need library-specific Jelly docs not covered in the local reference, fetch the URL listed in the "Further Documentation" section of `jelly.instructions.md`.

---

## The Shim Pattern

IDE-specific files (`.github/prompts/`, `.cursor/rules/`) are **shims** — they exist only to activate IDE tooling and immediately redirect the agent to `.agent/`. They contain no logic of their own.

**Rule:** Never add logic to a shim file. Add it to `.agent/` and have the shim reference it.

If you need to add a new IDE integration, create a shim in the appropriate IDE folder and point it to the relevant `.agent/skills/` or `.agent/rules/` path.

---

## Tooling & Execution (The Makefile)

Do not attempt to write raw `jelly` or `shortcuts` CLI commands from memory. All actionable project commands are standardized in the root `Makefile`.

When asked to perform a task, use your terminal access to run the following:

- **Compile a script:** `make build FILE=<category/script-name.jelly>`
- **Sign a compiled shortcut:** `make sign FILE=<category/script-name.jelly>`
- **Compile, sign, and deploy:** `make deploy FILE=<category/script-name.jelly>`
- **Decompile from iOS:** `make decompile FILE=<file.shortcut>`
