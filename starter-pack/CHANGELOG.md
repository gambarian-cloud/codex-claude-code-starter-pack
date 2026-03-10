# Changelog

## v0.6.1 - 2026-03-10

One-button beginner install pass.

Added:

- auto-start install flow from `INSTALL-STARTER-PACK.cmd`
- built-in on-screen "what to do next" guidance while the installer runs

Changed:

- root release surface is now a single visible install path plus one copy-paste prompt
- branding is now `Starter Pack 2026` instead of `Starter Pack 95`
- root and starter-pack readmes now describe the one-button install flow

## v0.6.0 - 2026-03-10

Retro installer pass.

Added:

- `STARTER-PACK-LAUNCHER.ps1` as a Windows retro-style launcher for install, verify, and uninstall
- live launcher actions for install, verify, uninstall, and opening next steps
- wrapper `.cmd` files now open the launcher instead of a plain console-first flow

Changed:

- `INSTALL-STARTER-PACK.cmd` now opens a friendly setup window instead of dropping the user straight into a console
- `STARTER-PACK-README.md`, `starter-pack/README.md`, and `OPEN-THIS-FIRST.txt` now describe the retro launcher flow

## v0.5.1 - 2026-03-10

Beginner onboarding pass.

Added:

- `WHAT-TO-DO-NEXT.txt` with simple first-project guidance in plain language
- `PASTE-INTO-CODEX-OR-CLAUDE-INSTALL.txt` as the default no-terminal install prompt
- installer wrappers now keep the window open and open the next-steps note after a successful install

Changed:

- `INSTALL-STARTER-PACK.cmd` now targets the build-ready default path
- the default no-choice path inside `INSTALL.ps1` now falls back to `websites`
- root and starter-pack readmes now explain the click-or-paste onboarding flow more plainly

## v0.5.0 - 2026-03-10

Starter Pack now has a real beginner-facing release surface.

Added:

- root one-click launchers: `INSTALL-STARTER-PACK.cmd`, `VERIFY-STARTER-PACK.cmd`, `UNINSTALL-STARTER-PACK.cmd`
- `OPEN-THIS-FIRST.txt` for non-technical users who open the ZIP root and need one obvious next step
- three root copy-paste prompt files for no-terminal installs through Codex or Claude Code
- `PACK-WINDOWS-RELEASE.ps1` to build a shareable Windows ZIP artifact

Changed:

- the main beginner UX is now `click or paste`, not terminal-first
- `starter-pack/README.md` now explains the real end-user flow from a GitHub ZIP
- `STARTER-PACK-README.md` now explains the root-level release surface plainly

## v0.4.1 - 2026-03-10

Release-candidate blocker fixes from independent Claude Code review.

Fixed:

- preserved `${GITHUB_PERSONAL_ACCESS_TOKEN}` literally in Claude GitHub MCP headers so Claude Code can expand it at runtime
- switched Claude deny rules from ambiguous Windows-style home paths to documented `~`-based permission patterns
- synced the deny-rule and MCP guidance across `INSTALL.ps1`, `APPLY.md`, and `manifests/core-baseline.md`
- clarified that `core-baseline.md` shows reference JSON while the real install mechanics live in `APPLY.md`

## v0.4.0 - 2026-03-10

Starter Pack is now a complete beginner install product, not just a document set.

Added:

- `UNINSTALL.ps1` for rollback using the install receipt and backups
- installer prerequisite checks for Git and Node
- profile-aware install receipt entries with explicit target paths
- backup paths that preserve the real user file structure

Changed:

- `INSTALL.ps1` now writes the official read-only GitHub MCP URL for Codex
- `README.md` now presents install, verify, and undo as the main user flow
- `APPLY.md` now matches the real automated installer and manual fallback path
- `VERIFY.md` now points to `VERIFY.ps1` first and keeps manual checks as fallback
- `PRD.md` now reflects the real shipped MVP shape

Cleaned up:

- removed outdated references to `skill-pack/`
- aligned the docs around `skills/` as the only install source of truth
