param(
  [ValidateSet("general-use", "websites", "simple-apps")]
  [string]$Profile = "general-use"
)

$ErrorActionPreference = "Stop"

function Test-Check {
  param(
    [string]$Label,
    [scriptblock]$Check
  )

  try {
    $result = & $Check
    if ($result) {
      Write-Host "[ok] $Label" -ForegroundColor Green
      return $true
    }
    Write-Host "[missing] $Label" -ForegroundColor Yellow
    return $false
  } catch {
    Write-Host "[error] $Label :: $($_.Exception.Message)" -ForegroundColor Red
    return $false
  }
}

$allGood = $true
$codexRoot = Join-Path $env:USERPROFILE ".codex"
$claudeRoot = Join-Path $env:USERPROFILE ".claude"

Write-Host "Starter Pack verification for profile: $Profile" -ForegroundColor Cyan
Write-Host ""

$allGood = (Test-Check "Codex AGENTS.md" { Test-Path (Join-Path $codexRoot "AGENTS.md") }) -and $allGood
$allGood = (Test-Check "Claude CLAUDE.md" { Test-Path (Join-Path $claudeRoot "CLAUDE.md") }) -and $allGood
$allGood = (Test-Check "Claude settings.json" { Test-Path (Join-Path $claudeRoot "settings.json") }) -and $allGood
$allGood = (Test-Check "Codex config.toml" { Test-Path (Join-Path $codexRoot "config.toml") }) -and $allGood

$coreSkills = @(
  "brainstorming",
  "writing-plans",
  "executing-plans",
  "systematic-debugging",
  "verification-before-completion",
  "using-git-worktrees"
)

foreach ($skill in $coreSkills) {
  $allGood = (Test-Check "Codex skill $skill" { Test-Path (Join-Path $codexRoot "skills\$skill\SKILL.md") }) -and $allGood
  $allGood = (Test-Check "Claude skill $skill" { Test-Path (Join-Path $claudeRoot "skills\$skill\SKILL.md") }) -and $allGood
}

$allGood = (Test-Check "Codex skill model-routing" { Test-Path (Join-Path $codexRoot "skills\model-routing\SKILL.md") }) -and $allGood

if ($Profile -in @("websites", "simple-apps")) {
  $allGood = (Test-Check "Codex skill test-driven-development" { Test-Path (Join-Path $codexRoot "skills\test-driven-development\SKILL.md") }) -and $allGood
  $allGood = (Test-Check "Claude skill test-driven-development" { Test-Path (Join-Path $claudeRoot "skills\test-driven-development\SKILL.md") }) -and $allGood
}

if ($Profile -eq "websites") {
  $allGood = (Test-Check "Codex skill react-best-practices" { Test-Path (Join-Path $codexRoot "skills\react-best-practices\SKILL.md") }) -and $allGood
  $allGood = (Test-Check "Claude skill react-best-practices" { Test-Path (Join-Path $claudeRoot "skills\react-best-practices\SKILL.md") }) -and $allGood
}

$allGood = (Test-Check "Codex config contains Context7" {
    (Get-Content -Raw (Join-Path $codexRoot "config.toml")) -match '\[mcp_servers\.context7\]'
  }) -and $allGood
$allGood = (Test-Check "Codex config contains Sequential Thinking" {
    (Get-Content -Raw (Join-Path $codexRoot "config.toml")) -match '\[mcp_servers\.sequential_thinking\]'
  }) -and $allGood
$allGood = (Test-Check "Codex config contains GitHub MCP" {
    (Get-Content -Raw (Join-Path $codexRoot "config.toml")) -match '\[mcp_servers\.github\]'
  }) -and $allGood

if (Get-Command claude -ErrorAction SilentlyContinue) {
  $claudeMcpList = & claude mcp list 2>$null
  $allGood = (Test-Check "Claude MCP context7" { $claudeMcpList -match 'context7' }) -and $allGood
  $allGood = (Test-Check "Claude MCP sequential-thinking" { $claudeMcpList -match 'sequential-thinking' }) -and $allGood
} else {
  Write-Host "[skip] Claude CLI not found. MCP list check skipped." -ForegroundColor Yellow
}

Write-Host ""
if ($allGood) {
  Write-Host "Starter Pack verification passed." -ForegroundColor Green
  exit 0
}

Write-Host "Starter Pack verification found missing items." -ForegroundColor Yellow
exit 1
