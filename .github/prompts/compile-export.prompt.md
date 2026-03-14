---
agent: agent
description: Compile the current Jelly shortcut using the jelly CLI and surface any errors.
---

You are compiling and signing a Jelly shortcut in this repository. Follow the steps below.

## Step 1 — Identify the Target File

Use the currently open `.jelly` file as the compile target. If no `.jelly` file is open, ask the user which file to compile.

## Step 2 — Ensure Build Directories Exist

```sh
mkdir -p build/unsigned
```

`build/unsigned/` holds raw compiler output. `build/` holds the final signed, importable shortcuts.

## Step 3 — Pre-flight: Verify iCloud Identity

Run a heartbeat check before signing. If this returns an empty list or an error, signing will fail.

```sh
shortcuts list | head -3
```

If the command fails, tell the user: "iCloud is not accessible from this session. Signing requires an active iCloud login. Resolve that before continuing."

## Step 4 — Run the Compiler

```sh
~/bin/jelly <filename>.jelly --export --out build/unsigned/<shortname>.shortcut
```

Replace `<filename>` with the relative path (e.g. `utilities/flashlight-blink.jelly`) and `<shortname>` with the base name without extension (e.g. `flashlight-blink`).

**If the compiler reports errors:** display each error with its line number, then tell the user to run `/fix-compiler-error`. Stop here.

## Step 5 — Sign the Shortcut

Apple devices reject unsigned `.shortcut` files. Run:

```sh
shortcuts sign --mode anyone \
  --input  build/unsigned/<shortname>.shortcut \
  --output build/<shortname>.shortcut
```

- `--mode anyone` makes the shortcut importable by any Apple ID, not just contacts.
- Signing sends a hash of the file to Apple's servers for validation and embeds a cryptographic signature. It requires an internet connection.
- The signed file will be noticeably larger than the unsigned one (Apple appends signature data).

**If exit code is non-zero:** check iCloud status and internet connectivity, then retry once. If it fails again, report the error.

## Step 6 — Confirm and Proceed

- Confirm the signed file exists in `build/` and report its size.
- Tell the user: "Signed shortcut ready at `build/<shortname>.shortcut`. Run `/deploy-to-device` to transfer it to your iPhone."

## Rules

- Always use `--export` with `jelly` — without it, no `.shortcut` file is produced.
- Never skip the sign step. Unsigned files will be rejected on import by iOS/macOS.
- The `build/` directory is gitignored — never commit `.shortcut` files.
