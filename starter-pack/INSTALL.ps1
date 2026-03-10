param(
  [ValidateSet("general-use", "websites", "simple-apps")]
  [string]$Profile,
  [switch]$SkipClaudeMcp,
  [switch]$SkipCodexMcp,
  [switch]$SkipVerify
)

$ErrorActionPreference = "Stop"

$script:StarterPackVersion = "0.6.5"
$script:StarterPackRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$script:AssetsRoot = Join-Path $script:StarterPackRoot "assets"
$script:SkillsRoot = Join-Path $script:StarterPackRoot "skills"
$script:UserRoot = Join-Path $env:USERPROFILE ".starter-pack"
$script:BackupRoot = Join-Path $script:UserRoot "backups"
$script:ReceiptPath = Join-Path $script:UserRoot "install-receipt.json"

function Write-Step {
  param([string]$Message)
  Write-Host ""
  Write-Host "==> $Message" -ForegroundColor Cyan
}

function Ensure-Directory {
  param([string]$Path)
  if (-not (Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

function Assert-CommandExists {
  param(
    [string]$CommandName,
    [string]$HelpMessage
  )

  if (-not (Get-Command $CommandName -ErrorAction SilentlyContinue)) {
    throw "$CommandName was not found. $HelpMessage"
  }
}

function Get-BackupDestination {
  param(
    [string]$SourcePath,
    [string]$BackupBase
  )

  $normalizedUserRoot = [IO.Path]::GetFullPath($env:USERPROFILE)
  $normalizedSource = [IO.Path]::GetFullPath($SourcePath)

  if ($normalizedSource.StartsWith($normalizedUserRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    $relative = $normalizedSource.Substring($normalizedUserRoot.Length).TrimStart('\')
    return Join-Path $BackupBase $relative
  }

  return Join-Path $BackupBase (Split-Path -Leaf $SourcePath)
}

function Backup-PathIfPresent {
  param(
    [string]$SourcePath,
    [string]$BackupBase
  )

  if (-not (Test-Path $SourcePath)) {
    return $null
  }

  $destination = Get-BackupDestination -SourcePath $SourcePath -BackupBase $BackupBase
  Ensure-Directory -Path (Split-Path -Parent $destination)

  if (Test-Path $destination) {
    Remove-Item -Recurse -Force $destination
  }

  Copy-Item -Recurse -Force $SourcePath $destination
  return $destination
}

function Copy-FileWithBackup {
  param(
    [string]$SourcePath,
    [string]$DestinationPath,
    [string]$BackupBase
  )

  Ensure-Directory -Path (Split-Path -Parent $DestinationPath)
  $backup = Backup-PathIfPresent -SourcePath $DestinationPath -BackupBase $BackupBase
  Copy-Item -Force $SourcePath $DestinationPath
  return $backup
}

function Copy-SkillFolder {
  param(
    [string]$SkillName,
    [string]$DestinationBase,
    [string]$BackupBase
  )

  $source = Join-Path $script:SkillsRoot $SkillName
  $destination = Join-Path $DestinationBase $SkillName
  if (-not (Test-Path $source)) {
    throw "Starter Pack skill was not found: $source"
  }
  Ensure-Directory -Path $DestinationBase
  $backup = Backup-PathIfPresent -SourcePath $destination -BackupBase $BackupBase
  if (Test-Path $destination) {
    Remove-Item -Recurse -Force $destination
  }
  Copy-Item -Recurse -Force $source $destination
  return $backup
}

function Merge-ClaudeSettings {
  param(
    [string]$DestinationPath,
    [string]$BackupBase
  )

  $denyRules = @(
    "Read(./.env)",
    "Read(./.env.*)",
    "Read(./secrets/**)",
    "Read(~/.ssh/**)",
    "Read(~/.aws/**)"
  )

  $backup = Backup-PathIfPresent -SourcePath $DestinationPath -BackupBase $BackupBase

  if (Test-Path $DestinationPath) {
    $settings = Get-Content -Raw $DestinationPath | ConvertFrom-Json
  } else {
    $settings = New-Object psobject
  }

  if (-not ($settings.PSObject.Properties.Name -contains "permissions")) {
    Add-Member -InputObject $settings -MemberType NoteProperty -Name "permissions" -Value (New-Object psobject)
  }

  if (-not ($settings.permissions.PSObject.Properties.Name -contains "deny")) {
    Add-Member -InputObject $settings.permissions -MemberType NoteProperty -Name "deny" -Value @()
  }

  $currentDeny = @($settings.permissions.deny)
  foreach ($rule in $denyRules) {
    if ($currentDeny -notcontains $rule) {
      $currentDeny += $rule
    }
  }

  $settings.permissions.deny = $currentDeny
  $settings | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $DestinationPath
  return $backup
}

function Ensure-CodexConfig {
  param(
    [string]$DestinationPath,
    [string]$BackupBase,
    [bool]$InstallMcp
  )

  $backup = Backup-PathIfPresent -SourcePath $DestinationPath -BackupBase $BackupBase

  $content = ""
  if (Test-Path $DestinationPath) {
    $content = Get-Content -Raw $DestinationPath
  }

  $blocks = @(
    @{
      Marker = 'status_line = ["model-name", "context-remaining", "used-tokens", "git-branch", "current-dir"]'
      Text = @'
[tui]
status_line = ["model-name", "context-remaining", "used-tokens", "git-branch", "current-dir"]
'@
    },
    @{
      Marker = '[windows]'
      Text = @'
[windows]
sandbox = "elevated"
'@
    }
  )

  if ($InstallMcp) {
    $blocks += @(
      @{
        Marker = '[mcp_servers.context7]'
        Text = @'
[mcp_servers.context7]
args = ["/c", "npx", "-y", "@upstash/context7-mcp"]
command = "cmd"
'@
      },
      @{
        Marker = '[mcp_servers.sequential_thinking]'
        Text = @'
[mcp_servers.sequential_thinking]
args = ["/c", "npx", "-y", "@modelcontextprotocol/server-sequential-thinking"]
command = "cmd"
'@
      },
      @{
        Marker = '[mcp_servers.github]'
        Text = @'
[mcp_servers.github]
url = "https://api.githubcopilot.com/mcp/readonly"
bearer_token_env_var = "GITHUB_PERSONAL_ACCESS_TOKEN"
'@
      }
    )
  }

  foreach ($block in $blocks) {
    if ($content -notmatch [regex]::Escape($block.Marker)) {
      if ($content.Trim().Length -gt 0 -and -not $content.EndsWith("`n")) {
        $content += "`r`n"
      }
      $content += "`r`n" + $block.Text.Trim() + "`r`n"
    }
  }

  Set-Content -Encoding UTF8 $DestinationPath $content.TrimStart("`r", "`n")
  return $backup
}

function Add-ClaudeMcpServer {
  param(
    [string]$Name,
    [hashtable]$Config
  )

  if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    return $false
  }

  $json = $Config | ConvertTo-Json -Compress -Depth 8
  & claude mcp add-json $Name --scope user $json | Out-Null
  return $true
}

function Prompt-ForProfile {
  Write-Host ""
  Write-Host "Choose your Starter Pack profile:" -ForegroundColor Yellow
  Write-Host "1. General Use"
  Write-Host "2. Building Websites"
  Write-Host "3. Building Simple Apps"
  $choice = Read-Host "Enter 1, 2, or 3"

  if (-not $choice) {
    Write-Host "No choice entered. Using Websites." -ForegroundColor Yellow
    return "websites"
  }

  switch ($choice) {
    "1" { return "general-use" }
    "2" { return "websites" }
    "3" { return "simple-apps" }
    default {
      Write-Host "Unknown choice. Using Websites." -ForegroundColor Yellow
      return "websites"
    }
  }
}

Ensure-Directory -Path $script:UserRoot
Ensure-Directory -Path $script:BackupRoot

Assert-CommandExists -CommandName "git" -HelpMessage "Install Git for Windows, then reopen PowerShell and run the installer again."
Assert-CommandExists -CommandName "node" -HelpMessage "Install the Node.js LTS release, then reopen PowerShell and run the installer again."

if (-not $Profile) {
  $Profile = Prompt-ForProfile
}

$timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"
$backupPath = Join-Path $script:BackupRoot $timestamp
Ensure-Directory -Path $backupPath

$codexRoot = Join-Path $env:USERPROFILE ".codex"
$claudeRoot = Join-Path $env:USERPROFILE ".claude"
$codexSkills = Join-Path $codexRoot "skills"
$claudeSkills = Join-Path $claudeRoot "skills"

$receipt = [ordered]@{
  installedAt = (Get-Date).ToString("s")
  version = $script:StarterPackVersion
  profile = $Profile
  backupPath = $backupPath
  installedFiles = @()
  installedSkills = @()
  notes = @()
}

Write-Step "Installing global instruction files"
$receipt.installedFiles += @{
  kind = "file"
  target = (Join-Path $codexRoot "AGENTS.md")
  backup = (Copy-FileWithBackup -SourcePath (Join-Path $script:AssetsRoot "codex\AGENTS.md") -DestinationPath (Join-Path $codexRoot "AGENTS.md") -BackupBase $backupPath)
}
$receipt.installedFiles += @{
  kind = "file"
  target = (Join-Path $claudeRoot "CLAUDE.md")
  backup = (Copy-FileWithBackup -SourcePath (Join-Path $script:AssetsRoot "claude\CLAUDE.md") -DestinationPath (Join-Path $claudeRoot "CLAUDE.md") -BackupBase $backupPath)
}

Write-Step "Installing core skills"
$coreSkills = @(
  "brainstorming",
  "deep-research",
  "writing-plans",
  "executing-plans",
  "systematic-debugging",
  "verification-before-completion",
  "using-git-worktrees"
)

foreach ($skill in $coreSkills) {
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "codex"
    name = $skill
    target = (Join-Path $codexSkills $skill)
    backup = (Copy-SkillFolder -SkillName $skill -DestinationBase $codexSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "claude"
    name = $skill
    target = (Join-Path $claudeSkills $skill)
    backup = (Copy-SkillFolder -SkillName $skill -DestinationBase $claudeSkills -BackupBase $backupPath)
  }
}

Write-Step "Installing presentation skill"
$receipt.installedSkills += @{
  kind = "directory"
  tool = "codex"
  name = "presentations"
  target = (Join-Path $codexSkills "presentations")
  backup = (Copy-SkillFolder -SkillName "presentations" -DestinationBase $codexSkills -BackupBase $backupPath)
}
$receipt.installedSkills += @{
  kind = "directory"
  tool = "claude"
  name = "presentations"
  target = (Join-Path $claudeSkills "presentations")
  backup = (Copy-SkillFolder -SkillName "presentations" -DestinationBase $claudeSkills -BackupBase $backupPath)
}

$receipt.installedSkills += @{
  kind = "directory"
  tool = "codex"
  name = "model-routing"
  target = (Join-Path $codexSkills "model-routing")
  backup = (Copy-SkillFolder -SkillName "model-routing" -DestinationBase $codexSkills -BackupBase $backupPath)
}

if ($Profile -in @("websites", "simple-apps")) {
  Write-Step "Installing builder skills"
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "codex"
    name = "test-driven-development"
    target = (Join-Path $codexSkills "test-driven-development")
    backup = (Copy-SkillFolder -SkillName "test-driven-development" -DestinationBase $codexSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "claude"
    name = "test-driven-development"
    target = (Join-Path $claudeSkills "test-driven-development")
    backup = (Copy-SkillFolder -SkillName "test-driven-development" -DestinationBase $claudeSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "codex"
    name = "web-design-guidelines"
    target = (Join-Path $codexSkills "web-design-guidelines")
    backup = (Copy-SkillFolder -SkillName "web-design-guidelines" -DestinationBase $codexSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "claude"
    name = "web-design-guidelines"
    target = (Join-Path $claudeSkills "web-design-guidelines")
    backup = (Copy-SkillFolder -SkillName "web-design-guidelines" -DestinationBase $claudeSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "codex"
    name = "playwright"
    target = (Join-Path $codexSkills "playwright")
    backup = (Copy-SkillFolder -SkillName "playwright" -DestinationBase $codexSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "claude"
    name = "playwright"
    target = (Join-Path $claudeSkills "playwright")
    backup = (Copy-SkillFolder -SkillName "playwright" -DestinationBase $claudeSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "codex"
    name = "vercel-deploy"
    target = (Join-Path $codexSkills "vercel-deploy")
    backup = (Copy-SkillFolder -SkillName "vercel-deploy" -DestinationBase $codexSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "claude"
    name = "vercel-deploy"
    target = (Join-Path $claudeSkills "vercel-deploy")
    backup = (Copy-SkillFolder -SkillName "vercel-deploy" -DestinationBase $claudeSkills -BackupBase $backupPath)
  }
}

if ($Profile -eq "websites") {
  Write-Step "Installing website-specific skill"
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "codex"
    name = "react-best-practices"
    target = (Join-Path $codexSkills "react-best-practices")
    backup = (Copy-SkillFolder -SkillName "react-best-practices" -DestinationBase $codexSkills -BackupBase $backupPath)
  }
  $receipt.installedSkills += @{
    kind = "directory"
    tool = "claude"
    name = "react-best-practices"
    target = (Join-Path $claudeSkills "react-best-practices")
    backup = (Copy-SkillFolder -SkillName "react-best-practices" -DestinationBase $claudeSkills -BackupBase $backupPath)
  }
}

Write-Step "Applying Claude Code safety settings"
$receipt.installedFiles += @{
  kind = "file"
  target = (Join-Path $claudeRoot "settings.json")
  backup = (Merge-ClaudeSettings -DestinationPath (Join-Path $claudeRoot "settings.json") -BackupBase $backupPath)
}

Write-Step "Updating Codex config"
$receipt.installedFiles += @{
  kind = "file"
  target = (Join-Path $codexRoot "config.toml")
  backup = (Ensure-CodexConfig -DestinationPath (Join-Path $codexRoot "config.toml") -BackupBase $backupPath -InstallMcp (-not $SkipCodexMcp.IsPresent))
}

if (-not $SkipClaudeMcp) {
  Write-Step "Adding Claude Code MCP servers"
  if (Get-Command claude -ErrorAction SilentlyContinue) {
    $claudeMcpAdded = $true
    $claudeMcpAdded = (Add-ClaudeMcpServer -Name "context7" -Config @{
        command = "cmd"
        args = @("/c", "npx", "-y", "@upstash/context7-mcp")
      }) -and $claudeMcpAdded
    $claudeMcpAdded = (Add-ClaudeMcpServer -Name "sequential-thinking" -Config @{
        command = "cmd"
        args = @("/c", "npx", "-y", "@modelcontextprotocol/server-sequential-thinking")
      }) -and $claudeMcpAdded

    $githubToken = [Environment]::GetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", "User")
    if (-not $githubToken) {
      $githubToken = Read-Host "Optional: enter a GitHub Personal Access Token for read-only GitHub MCP (leave blank to skip)"
      if ($githubToken) {
        [Environment]::SetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", $githubToken, "User")
      }
    }

    if ($githubToken) {
      $claudeMcpAdded = (Add-ClaudeMcpServer -Name "github" -Config @{
          type = "http"
          url = "https://api.githubcopilot.com/mcp/readonly"
          headers = @{
            Authorization = 'Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}'
          }
        }) -and $claudeMcpAdded
    } else {
      $receipt.notes += "GitHub MCP was skipped for Claude Code because no GitHub token was provided."
    }

    if (-not $claudeMcpAdded) {
      $receipt.notes += "Claude MCP add did not fully succeed. Run the manual Claude MCP steps in APPLY.md."
    }
  } else {
    $receipt.notes += "Claude CLI was not available. Claude MCP servers were not added automatically."
  }
}

if ($SkipCodexMcp) {
  $receipt.notes += "Codex MCP setup was skipped."
}

$receipt | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $script:ReceiptPath

Write-Step "Install complete"
Write-Host "Profile installed: $Profile" -ForegroundColor Green
Write-Host "Backup saved to: $backupPath" -ForegroundColor Green
Write-Host "Receipt saved to: $script:ReceiptPath" -ForegroundColor Green
Write-Host "If you ever want to roll back, run UNINSTALL.ps1 from this folder." -ForegroundColor Green

if (-not $SkipVerify) {
  Write-Step "Running verification"
  & (Join-Path $script:StarterPackRoot "VERIFY.ps1") -Profile $Profile
}



