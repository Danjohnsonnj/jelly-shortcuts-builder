---
agent: agent
description: Compile the current Jelly shortcut using the jelly CLI and surface any errors.
---

You are compiling a Jelly shortcut in this repository. Follow the steps below.

## Step 1 — Identify the Target File

Use the currently open `.jelly` file as the compile target. If no `.jelly` file is open, ask the user which file to compile.

## Step 2 — Ensure the Build Directory Exists

The output goes to `./build/`. If the directory does not exist, create it:

```sh
mkdir -p build
```

## Step 3 — Run the Compiler

Run the following command in the terminal:

```sh
jelly <filename>.jelly --export --out ./build/
```

Replace `<filename>` with the relative path to the file (e.g. `utilities/flashlight-blink.jelly`).

## Step 4 — Evaluate the Output

**If the compiler succeeds:**

- Confirm which `.shortcut` file was written to `build/`
- Tell the user: "Compilation succeeded. Run `/deploy-to-device` to transfer it to your iPhone."

**If the compiler reports errors:**

- Display each error clearly, including line number and message
- Tell the user: "Run `/fix-compiler-error` to diagnose and fix these errors."
- Do not attempt to auto-fix errors in this prompt — that is the job of `/fix-compiler-error`

## Rules

- Always use the `--export` flag — without it, `jelly` only syntax-checks and does not produce a `.shortcut` file.
- Always use `--out ./build/` to keep compiled output out of the source tree.
- The `build/` directory is gitignored — never commit `.shortcut` files.
