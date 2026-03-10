param(
  [string]$OutputDirectory = (Join-Path $PSScriptRoot "dist")
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$installerPath = Join-Path $PSScriptRoot "INSTALL.ps1"
$versionMatch = Select-String -Path $installerPath -Pattern '\$script:StarterPackVersion = "([^"]+)"'

if (-not $versionMatch.Matches.Count) {
  throw "Could not read Starter Pack version from INSTALL.ps1"
}

$version = $versionMatch.Matches[0].Groups[1].Value
$stageRoot = Join-Path $OutputDirectory "Starter-Pack-Windows-v$version"
$zipPath = Join-Path $OutputDirectory "Starter-Pack-Windows-v$version.zip"

if (Test-Path $stageRoot) {
  Remove-Item -Recurse -Force $stageRoot
}

if (Test-Path $zipPath) {
  Remove-Item -Force $zipPath
}

New-Item -ItemType Directory -Path $stageRoot -Force | Out-Null

Copy-Item -Force (Join-Path $repoRoot "OPEN-THIS-FIRST.txt") (Join-Path $stageRoot "OPEN-THIS-FIRST.txt")
Copy-Item -Force (Join-Path $repoRoot "WHAT-TO-DO-NEXT.txt") (Join-Path $stageRoot "WHAT-TO-DO-NEXT.txt")
Copy-Item -Force (Join-Path $repoRoot "STARTER-PACK-LAUNCHER.ps1") (Join-Path $stageRoot "STARTER-PACK-LAUNCHER.ps1")
Copy-Item -Force (Join-Path $repoRoot "INSTALL-STARTER-PACK.cmd") (Join-Path $stageRoot "INSTALL-STARTER-PACK.cmd")
Copy-Item -Force (Join-Path $repoRoot "STARTER-PACK-README.md") (Join-Path $stageRoot "STARTER-PACK-README.md")
Copy-Item -Force (Join-Path $repoRoot "PASTE-INTO-CODEX-OR-CLAUDE-INSTALL.txt") (Join-Path $stageRoot "PASTE-INTO-CODEX-OR-CLAUDE-INSTALL.txt")

$starterPackStage = Join-Path $stageRoot "starter-pack"
New-Item -ItemType Directory -Path $starterPackStage -Force | Out-Null
Get-ChildItem -Force $PSScriptRoot | Where-Object { $_.Name -ne "dist" } | ForEach-Object {
  Copy-Item -Recurse -Force $_.FullName (Join-Path $starterPackStage $_.Name)
}

Compress-Archive -Path (Join-Path $stageRoot "*") -DestinationPath $zipPath -Force

Write-Host "Created Starter Pack release folder: $stageRoot" -ForegroundColor Green
Write-Host "Created Starter Pack ZIP: $zipPath" -ForegroundColor Green
