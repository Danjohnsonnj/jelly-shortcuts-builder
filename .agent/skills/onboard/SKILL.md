---
name: onboard-agent
description: The required first-run boot sequence for any new AI agent entering this repository.
---

# Agent Onboarding Sequence

If you have just been initialized in this repository, you MUST complete this checklist before assisting the user:

1. **Acknowledge the Source of Truth:** Read `.agent/rules/jelly-syntax.md` to understand the core language constraints.
2. **Review Available Skills:** List the directories inside `.agent/skills/` so you know what reusable playbooks are available to you.
3. **Verify Tooling:** Run `make --version` and `~/bin/jelly --version` (if terminal access is available) to confirm your environment is ready.
4. **Report Status:** Reply to the user with: _"Environment indexed. I have read the `jelly-syntax` rules and am ready to build. What are we automating today?"_
