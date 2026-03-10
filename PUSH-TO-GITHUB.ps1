$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoRoot

$owner = "gambarian-cloud"
$repoName = "starter-pack-windows"
$remoteUrl = "https://github.com/$owner/$repoName.git"

$token = if ($env:GITHUB_PERSONAL_ACCESS_TOKEN) {
  $env:GITHUB_PERSONAL_ACCESS_TOKEN
} elseif ($env:GITHUB_TOKEN) {
  $env:GITHUB_TOKEN
} else {
  throw "No GitHub token found in environment."
}

$basic = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("x-access-token:$token"))

$originExists = $false
try {
  $null = git remote get-url origin 2>$null
  $originExists = $true
} catch {
  $originExists = $false
}

if (-not $originExists) {
  git remote add origin $remoteUrl | Out-Null
} else {
  git remote set-url origin $remoteUrl | Out-Null
}

git -c http.extraheader="AUTHORIZATION: basic $basic" push -u origin main --tags

if ($LASTEXITCODE -ne 0) {
  throw "Git push failed. The repository was not published."
}

Write-Host "Published to $remoteUrl" -ForegroundColor Green
