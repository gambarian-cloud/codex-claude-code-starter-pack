# Apply The Starter Pack

There are two install paths:

- automatic install with `INSTALL.ps1` or `START-HERE.cmd` - recommended
- manual install - only if you want to understand or repair each step yourself

## Before you start

Open PowerShell and check the basics:

```powershell
git --version
node --version
```

If one of those commands fails:

- install Git from [git-scm.com/downloads/win](https://git-scm.com/downloads/win)
- install Node.js LTS from [nodejs.org](https://nodejs.org)
- close PowerShell and open it again

You should also already have Codex and/or Claude Code installed on this PC.

## Option A: automatic install

### Easiest path

Double-click `START-HERE.cmd`.

That launcher runs `INSTALL.ps1`, asks you to choose a profile, installs the files, writes a backup, and runs verification.

### PowerShell path

Run the installer directly:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\INSTALL.ps1"
```

Skip the menu and choose a profile up front:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\INSTALL.ps1" -Profile websites
```

Available profiles:

- `general-use`
- `websites`
- `simple-apps`

### What the installer does

1. Creates the needed `%USERPROFILE%\.codex` and `%USERPROFILE%\.claude` folders.
2. Copies the global instruction files from `assets/`.
3. Installs the core skills from `skills/`.
4. Adds `model-routing` for Codex.
5. Adds presentation help for both tools.
6. Adds `test-driven-development` for builder profiles.
7. Adds `react-best-practices` for the websites profile.
8. Merges Claude Code deny rules into `settings.json`.
9. Updates Codex `config.toml` with the baseline MCP servers.
10. Adds Claude MCP servers through the Claude CLI if the CLI is available.
11. Saves backups to `%USERPROFILE%\.starter-pack\backups\...`.
12. Writes an install receipt to `%USERPROFILE%\.starter-pack\install-receipt.json`.
13. Runs `VERIFY.ps1` unless you skip it.

### Optional flags

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\INSTALL.ps1" -Profile simple-apps -SkipVerify
```

Available switches:

- `-SkipVerify`
- `-SkipClaudeMcp`
- `-SkipCodexMcp`

## Option B: manual install

Use this only if the automated path failed or you want to understand the files.

### Step 1: create the folders

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills" | Out-Null
```

### Step 2: copy the baseline instruction files

From this starter-pack folder:

- copy `assets/codex/AGENTS.md` to `%USERPROFILE%\.codex\AGENTS.md`
- copy `assets/claude/CLAUDE.md` to `%USERPROFILE%\.claude\CLAUDE.md`

PowerShell version:

```powershell
Copy-Item ".\assets\codex\AGENTS.md" "$env:USERPROFILE\.codex\AGENTS.md" -Force
Copy-Item ".\assets\claude\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md" -Force
```

### Step 3: copy the core skills

Install these for both tools:

- `brainstorming`
- `deep-research`
- `writing-plans`
- `executing-plans`
- `systematic-debugging`
- `verification-before-completion`
- `using-git-worktrees`

Install this for Codex only:

- `model-routing`

Helper script:

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
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills\$skill" | Out-Null
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\$skill" | Out-Null
  Copy-Item ".\skills\$skill\SKILL.md" "$env:USERPROFILE\.codex\skills\$skill\SKILL.md" -Force
  Copy-Item ".\skills\$skill\SKILL.md" "$env:USERPROFILE\.claude\skills\$skill\SKILL.md" -Force
}

New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills\model-routing" | Out-Null
Copy-Item ".\skills\model-routing\SKILL.md" "$env:USERPROFILE\.codex\skills\model-routing\SKILL.md" -Force

New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills\presentations" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\presentations" | Out-Null
Copy-Item ".\skills\presentations\SKILL.md" "$env:USERPROFILE\.codex\skills\presentations\SKILL.md" -Force
Copy-Item ".\skills\presentations\SKILL.md" "$env:USERPROFILE\.claude\skills\presentations\SKILL.md" -Force
```

### Step 4: add Claude Code safety rules

If `%USERPROFILE%\.claude\settings.json` does not exist yet, create it with these deny rules:

```json
{
  "permissions": {
      "deny": [
        "Read(./.env)",
        "Read(./.env.*)",
        "Read(./secrets/**)",
        "Read(~/.ssh/**)",
        "Read(~/.aws/**)"
      ]
    }
  }
```

If the file already exists, keep your existing settings and add only the missing deny rules.

### Step 5: add the MCP baseline

For Codex, add these blocks to `%USERPROFILE%\.codex\config.toml`:

```toml
[mcp_servers.context7]
args = ["/c", "npx", "-y", "@upstash/context7-mcp"]
command = "cmd"

[mcp_servers.sequential_thinking]
args = ["/c", "npx", "-y", "@modelcontextprotocol/server-sequential-thinking"]
command = "cmd"

[mcp_servers.github]
url = "https://api.githubcopilot.com/mcp/readonly"
bearer_token_env_var = "GITHUB_PERSONAL_ACCESS_TOKEN"
```

For Claude Code, use the Claude CLI if it is available:

```powershell
claude mcp add-json context7 --scope user "{\"command\":\"cmd\",\"args\":[\"/c\",\"npx\",\"-y\",\"@upstash/context7-mcp\"]}"
claude mcp add-json sequential-thinking --scope user "{\"command\":\"cmd\",\"args\":[\"/c\",\"npx\",\"-y\",\"@modelcontextprotocol/server-sequential-thinking\"]}"
```

GitHub MCP for Claude Code is optional. First set a user environment variable:

```powershell
[Environment]::SetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", "paste_your_token_here", "User")
```

Then add the read-only server:

```powershell
claude mcp add-json github --scope user "{\"type\":\"http\",\"url\":\"https://api.githubcopilot.com/mcp/readonly\",\"headers\":{\"Authorization\":\"Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}\"}}"
```

Claude Code expands `${GITHUB_PERSONAL_ACCESS_TOKEN}` from your environment when it reads the stored MCP config.

### Step 6: add the profile extras

Choose one:

- [General Use](profiles/general-use.md) - no extra install beyond core
- [Building Websites](profiles/websites.md) - add `test-driven-development`, then `react-best-practices` if you are actively building React or Next.js
- [Building Simple Apps](profiles/simple-apps.md) - add `test-driven-development`

Profile skill copy examples:

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills\test-driven-development" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\test-driven-development" | Out-Null
Copy-Item ".\skills\test-driven-development\SKILL.md" "$env:USERPROFILE\.codex\skills\test-driven-development\SKILL.md" -Force
Copy-Item ".\skills\test-driven-development\SKILL.md" "$env:USERPROFILE\.claude\skills\test-driven-development\SKILL.md" -Force
```

For the websites profile only:

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills\react-best-practices" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\react-best-practices" | Out-Null
Copy-Item ".\skills\react-best-practices\SKILL.md" "$env:USERPROFILE\.codex\skills\react-best-practices\SKILL.md" -Force
Copy-Item ".\skills\react-best-practices\SKILL.md" "$env:USERPROFILE\.claude\skills\react-best-practices\SKILL.md" -Force
```

### Step 7: verify

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\VERIFY.ps1" -Profile websites
```

Swap `websites` for your real profile.

## Undo the install

If you want to roll back:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\UNINSTALL.ps1"
```

That restores backups for files this pack replaced and removes files it created.

## Stop here

Do not immediately add:

- more MCP servers
- more hooks or plugins
- giant skill packs
- write-capable automation

If the core feels calm and useful, then it is doing its job.
