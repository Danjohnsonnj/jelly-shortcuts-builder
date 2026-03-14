---
agent: agent
description: Diagnose and fix a jelly compiler error in the current shortcut.
---

You are fixing a compiler error in a Jelly shortcut. Follow the steps below.

## Step 1 — Get the Error Output

Check the terminal for recent `jelly` compiler output. If the output is not visible, ask the user to paste the error message.

## Step 2 — Parse the Error

Extract from the error output:

- **File path** (which `.jelly` file)
- **Line number** (where the error occurred)
- **Error message** (what went wrong)

Common error patterns from the `jelly` CLI:

| Pattern                  | Likely cause                                                                               |
| ------------------------ | ------------------------------------------------------------------------------------------ |
| `Missing parameter name` | A function call is missing a required label (e.g. `wait(1)` instead of `wait(seconds: 1)`) |
| `Unexpected token`       | Syntax error — mismatched braces, bad operator, or unsupported construct                   |
| `Undefined variable`     | Variable used before declaration, or typo in variable name                                 |
| `Invalid type`           | `.as(Type)` mismatch, or wrong argument type for a function                                |
| `Unknown function`       | Function name doesn't exist or library not imported                                        |
| `Import not found`       | Library name is wrong (check the import name lookup table in the language reference)       |

## Step 3 — Open the File at the Error Line

Read the flagged file, focusing on the line number reported. Show the user the surrounding context (5 lines before and after).

## Step 4 — Diagnose the Problem

Using the Jelly language reference (loaded automatically when a `.jelly` file is open), identify the root cause. Cross-reference with the capability index and syntax quick-reference.

If you are unsure of a function's correct signature, fetch the corresponding documentation URL from the "Further Documentation" section of the language reference before proposing a fix.

## Step 5 — Propose and Apply the Fix

Explain what is wrong and why, then apply the fix to the file.

After fixing, tell the user: "Run `/compile-export` to verify the fix compiled successfully."

## Rules

- Fix only the reported error — do not refactor surrounding code.
- If the error indicates a function does not exist in Jelly, check whether an `importJSON` block is the correct fallback (see Section 14 of the language reference) before removing the call entirely.
- If the same error appears on multiple lines, fix all occurrences.
