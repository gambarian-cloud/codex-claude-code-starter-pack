# Verify The Starter Pack

Use the automated script first. Use the manual checks only if you want to inspect something by hand.

## Fast path

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\VERIFY.ps1" -Profile general-use
```

Swap `general-use` for `websites` or `simple-apps` if needed.

What the script checks:

- Codex `AGENTS.md`
- Claude `CLAUDE.md`
- Claude `settings.json`
- Codex `config.toml`
- all core skills in both tools
- `model-routing` in Codex
- `test-driven-development` for builder profiles
- `react-best-practices` for the websites profile
- Codex MCP blocks for Context7, Sequential Thinking, and GitHub
- Claude MCP names if the Claude CLI is available

If the script ends with `Starter Pack verification passed.`, the install is good.

## Manual checks

### Check 1: baseline files

```powershell
@(
  "$env:USERPROFILE\.codex\AGENTS.md",
  "$env:USERPROFILE\.claude\CLAUDE.md",
  "$env:USERPROFILE\.claude\settings.json",
  "$env:USERPROFILE\.codex\config.toml"
) | ForEach-Object {
  "{0}  {1}" -f ($(if (Test-Path $_) { "OK" } else { "MISSING" })), $_
}
```

### Check 2: core skills

```powershell
$coreSkills = @(
  "brainstorming",
  "writing-plans",
  "executing-plans",
  "systematic-debugging",
  "verification-before-completion",
  "using-git-worktrees"
)

foreach ($skill in $coreSkills) {
  "{0}  Claude {1}" -f ($(if (Test-Path "$env:USERPROFILE\.claude\skills\$skill\SKILL.md") { "OK" } else { "MISSING" })), $skill
  "{0}  Codex  {1}" -f ($(if (Test-Path "$env:USERPROFILE\.codex\skills\$skill\SKILL.md") { "OK" } else { "MISSING" })), $skill
}
```

### Check 3: profile extras

Builder profiles should also have:

```powershell
Test-Path "$env:USERPROFILE\.codex\skills\test-driven-development\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\test-driven-development\SKILL.md"
```

The websites profile should also have:

```powershell
Test-Path "$env:USERPROFILE\.codex\skills\react-best-practices\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\react-best-practices\SKILL.md"
```

### Check 4: Codex MCP config

```powershell
$codexConfig = Get-Content -Raw "$env:USERPROFILE\.codex\config.toml"
$codexConfig -match '\[mcp_servers\.context7\]'
$codexConfig -match '\[mcp_servers\.sequential_thinking\]'
$codexConfig -match '\[mcp_servers\.github\]'
```

Each line should return `True`.

### Check 5: optional GitHub token

```powershell
[Environment]::GetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", "User")
```

If that returns nothing, GitHub MCP stays unavailable until you add a token. That is okay for a first install.

## Quick smoke test

Open one of the tools and ask a simple question that should touch the installed skills:

- Claude Code: `What does the brainstorming skill tell you to do first?`
- Codex: `Which model should I use for a refactor?`

If the answer never mentions the installed skill, the files may be in the wrong folder.

## If something is wrong

1. Re-run `INSTALL.ps1`.
2. If you need to undo the install first, run `UNINSTALL.ps1`.
3. Then run `VERIFY.ps1` again.
