---
mode: agent
description: Transfer a compiled .shortcut file from build/ to iPhone.
---

You are helping the user transfer a compiled shortcut to their iPhone. Follow the steps below.

## Step 1 — Confirm the Build Exists

Check that a `.shortcut` file exists in `build/`. If it does not, tell the user to run `/compile-export` first.

## Step 2 — Scan for Third-Party Library Dependencies

Read the source `.jelly` file and look for `import` statements beyond `import Shortcuts`. For each third-party library found, notify the user that the corresponding app must be installed on the iPhone before the shortcut will run:

| Import                | Required App      |
| --------------------- | ----------------- |
| `import DataJar`      | Data Jar          |
| `import Drafts`       | Drafts            |
| `import Actions`      | Actions           |
| `import CARROT`       | CARROT Weather    |
| `import aShell`       | a-Shell           |
| `import aShellMini`   | a-Shell Mini      |
| `import Scriptable`   | Scriptable        |
| `import Rubyist`      | Rubyist           |
| `import GizmoPack`    | GizmoPack         |
| `import Nudget`       | Nudget            |
| `import Progress`     | Progress          |
| `import Recurrence`   | Recurrence        |
| `import FocusedWork`  | Focused Work      |
| `import Apollo`       | Apollo            |
| `import WidgetPack`   | WidgetPack        |
| `import Toolbox Pro`  | Toolbox Pro       |
| `import LinkBin`      | LinkBin           |
| `import WallpaperApp` | The Wallpaper App |

If all imports are from `import Shortcuts` only, no additional apps are needed.

## Step 3 — Choose a Transfer Method

Present the following options and follow the user's choice:

### Option A — AirDrop (fastest)

1. Open Finder on your Mac
2. Locate `build/<shortcut-name>.shortcut`
3. Right-click → Share → AirDrop → select your iPhone
4. On iPhone, tap **Accept** — the shortcut opens directly in the Shortcuts app

### Option B — iCloud Drive

1. Copy `build/<shortcut-name>.shortcut` to iCloud Drive (any folder)
2. On iPhone, open the **Files** app → iCloud Drive → locate the file
3. Tap the `.shortcut` file — it opens in the Shortcuts app

### Option C — URL Scheme (if shortcut is hosted online)

If the `.shortcut` file is accessible at a public URL:

```
shortcuts://import-shortcut?url=<encoded-url>&name=<encoded-name>
```

Open this URL on iPhone to trigger the Shortcuts import flow.

## Rules

- Never suggest Jellycuts Bridge — it is not part of this workflow.
- Always complete Step 2 before presenting transfer options; app dependency warnings must come first.
- If the user hasn't run `/compile-export` yet, redirect them there before proceeding.
