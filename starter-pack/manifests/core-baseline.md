# Core Baseline Manifest

This is the minimum baseline for every Starter Pack user.

## 1. Global instruction files

Create:

- `%USERPROFILE%\.codex\AGENTS.md`
- `%USERPROFILE%\.claude\CLAUDE.md`

Suggested `AGENTS.md` starter text:

```md
# Personal Codex Baseline

- Start with the repo AGENTS.md and follow project rules before improvising.
- If the task is unclear or large, plan before editing.
- Use the smallest change that solves the actual problem.
- Verify before claiming success.
- Treat tests, builds, and command output as evidence, not assumptions.
- Use isolated worktrees for risky or parallel tasks.
- Do not read or modify secrets, env files, SSH keys, or cloud credentials unless explicitly asked.
- Keep explanations short, practical, and specific to the current task.
```

Suggested `CLAUDE.md` starter text:

```md
# Personal Claude Code Baseline

- Start with the project CLAUDE.md and AGENTS.md before giving advice.
- Keep plans, memos, and instructions short and high signal.
- Prefer planning, review, diagnosis, and documentation over speculative code changes.
- If a task is unclear, compare options before recommending one.
- Verify claims against files, commands, or other concrete evidence.
- Use project memory and small reusable skills instead of bloated context files.
- Do not read or expose secrets, env files, SSH keys, or cloud credentials unless explicitly asked.
- Keep output practical, plain language, and easy to act on.
```

Why this matters:

- both tools start from a calmer and safer default

## 2. Core workflow skills

Install for both tools:

- `brainstorming`
- `deep-research`
- `writing-plans`
- `executing-plans`
- `systematic-debugging`
- `verification-before-completion`
- `using-git-worktrees`

Install for `Codex` only:

- `model-routing`

Skill sources:

- `systematic-debugging`, `verification-before-completion`, `using-git-worktrees` come from [obra/superpowers](https://github.com/obra/superpowers)
- `brainstorming`, `writing-plans`, `executing-plans` are adapted from practitioner planning patterns
- `deep-research` is a cross-cutting synthesis workflow promoted from our Signal Scout research passes
- `model-routing` is a Codex-native skill from [openai/skills](https://github.com/openai/skills)

Install paths:

- Claude Code: `%USERPROFILE%\.claude\skills\<skill-name>\SKILL.md`
- Codex: `%USERPROFILE%\.codex\skills\<skill-name>\SKILL.md`

Why this matters:

- this gives planning, research synthesis, implementation discipline, debugging, verification, and safe parallel work

## 3. Claude Code safety defaults

Add deny rules for:

- `Read(./.env)`
- `Read(./.env.*)`
- `Read(./secrets/**)`
- `Read(~/.ssh/**)`
- `Read(~/.aws/**)`

Why this matters:

- it lowers the chance of accidental secret exposure

## 4. MCP baseline

Install these three servers.

The JSON blocks below are reference format only.

Use the real install commands in [APPLY.md](../APPLY.md):

- Claude Code uses `claude mcp add-json ... --scope user`
- Codex uses `%USERPROFILE%\.codex\config.toml`

### Context7

Package: `@upstash/context7-mcp`

```json
{
  "context7": {
    "command": "cmd",
    "args": ["/c", "npx", "-y", "@upstash/context7-mcp"]
  }
}
```

What it does: gives your agent up-to-date documentation for libraries and frameworks.

### Sequential Thinking

Package: `@modelcontextprotocol/server-sequential-thinking`

```json
{
  "sequential-thinking": {
    "command": "cmd",
    "args": ["/c", "npx", "-y", "@modelcontextprotocol/server-sequential-thinking"]
  }
}
```

What it does: gives your agent a structured thinking tool for multi-step reasoning.

### GitHub MCP (read-only)

Endpoint: `https://api.githubcopilot.com/mcp/readonly`

```json
{
  "github": {
    "type": "http",
    "url": "https://api.githubcopilot.com/mcp/readonly",
    "headers": {
      "Authorization": "Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}"
    }
  }
}
```

What it does: gives your agent read-only access to GitHub repos, issues, and PRs.

Requires: a GitHub personal access token stored as `GITHUB_PERSONAL_ACCESS_TOKEN`.

### Config file locations

- Claude Code: `claude mcp add-json ... --scope user`
- Codex: `%USERPROFILE%\.codex\config.toml`

Why this matters:

- these are useful early and easier to trust than a larger MCP bundle

## 5. Verification baseline

After install, run the checks in [VERIFY.md](../VERIFY.md) or the automated `VERIFY.ps1` script.
