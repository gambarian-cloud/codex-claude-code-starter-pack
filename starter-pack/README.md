# Codex + Claude Code Starter Pack

A small, safe setup pack for fresh Codex and Claude Code users on Windows.

The beginner path is one-click install. No profile selection. No terminal-first flow. No setup quiz.

## What a real beginner does

### Option 1: just click install

If the person downloaded this ZIP from GitHub:

1. Extract the ZIP.
2. Double-click [INSTALL-STARTER-PACK.cmd](../INSTALL-STARTER-PACK.cmd).
3. A Starter Pack 2026 window opens and starts installing automatically.
4. Let the installer run.
5. Read [WHAT-TO-DO-NEXT.txt](../WHAT-TO-DO-NEXT.txt) when it opens.

This default path is aimed at the first thing most people want: ask for a site, app, landing page, presentation, or first small project.

### Option 2: already inside Codex or Claude Code

If the person already opened Codex or Claude Code, they can use a ready-made prompt instead of clicking the installer.

From the repo root, copy-paste [PASTE-INTO-CODEX-OR-CLAUDE-INSTALL.txt](../PASTE-INTO-CODEX-OR-CLAUDE-INSTALL.txt) into the chat.

That prompt tells the agent to find the local installer, run it, run verification, and report the result.

## What gets installed

### Default baseline

| Item | What it does |
|------|-------------|
| Global instruction files | Short behavior rules that make both tools calmer and more structured |
| Workflow skills | Planning, implementation, debugging, verification, and worktree discipline |
| Creation skills | Presentation help plus core support for first websites and apps, including React guidance, UI review, browser checking, and deploy guidance |
| Safety deny rules | Blocks Claude Code from casually reading common secret locations |
| Context7 MCP | Up-to-date library docs on demand |
| Sequential Thinking MCP | Step-by-step reasoning for hard problems |
| GitHub MCP (optional) | Read repos, issues, and PRs without a browser |

The visible product is one install. Internally, the installer chooses the build-ready default path so a new user can immediately ask for a website or app.

## What this pack is NOT

- A giant install-everything bundle
- Every MCP server someone mentioned online
- An advanced multi-agent framework
- A full automation suite
- A terminal-first product
- A multi-choice setup wizard

## What is in this folder

```text
starter-pack/
  START-HERE.cmd              <- local installer inside this folder
  INSTALL.ps1                 <- automated installer
  VERIFY.ps1                  <- automated verification script
  UNINSTALL.ps1               <- rollback helper
  README.md                   <- this file
  APPLY.md                    <- manual fallback guide
  VERIFY.md                   <- manual fallback guide
  PRD.md                      <- product spec
  CHANGELOG.md                <- version history
  PACK-WINDOWS-RELEASE.ps1    <- builds a release ZIP for sharing
  assets/
    codex/AGENTS.md
    claude/CLAUDE.md
  skills/
    brainstorming/
    writing-plans/
    executing-plans/
    systematic-debugging/
    verification-before-completion/
    using-git-worktrees/
    presentations/
    model-routing/
    test-driven-development/
    web-design-guidelines/
    playwright/
    vercel-deploy/
    react-best-practices/
```
