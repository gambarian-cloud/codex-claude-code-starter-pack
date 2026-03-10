param(
  [string]$ReceiptPath = (Join-Path $env:USERPROFILE ".starter-pack\install-receipt.json")
)

$ErrorActionPreference = "Stop"

function Ensure-Directory {
  param([string]$Path)
  if (-not (Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

function Restore-OrRemoveTarget {
  param(
    [psobject]$Entry
  )

  $target = $Entry.target
  $backup = $Entry.backup

  if (-not $target) {
    return
  }

  if ($backup -and (Test-Path $backup)) {
    if (Test-Path $target) {
      Remove-Item -Recurse -Force $target
    }
    Ensure-Directory -Path (Split-Path -Parent $target)
    Copy-Item -Recurse -Force $backup $target
    Write-Host "[restored] $target" -ForegroundColor Green
    return
  }

  if (Test-Path $target) {
    Remove-Item -Recurse -Force $target
    Write-Host "[removed] $target" -ForegroundColor Yellow
    return
  }

  Write-Host "[skip] $target" -ForegroundColor DarkYellow
}

if (-not (Test-Path $ReceiptPath)) {
  throw "Starter Pack install receipt was not found at $ReceiptPath"
}

$receipt = Get-Content -Raw $ReceiptPath | ConvertFrom-Json
$entries = @()
$entries += @($receipt.installedSkills)
$entries += @($receipt.installedFiles)
$entries = $entries | Where-Object { $_.target } | Sort-Object { $_.target.Length } -Descending

Write-Host "Rolling back Starter Pack install from $ReceiptPath" -ForegroundColor Cyan
Write-Host ""

foreach ($entry in $entries) {
  Restore-OrRemoveTarget -Entry $entry
}

Write-Host ""
Write-Host "Starter Pack file rollback is complete." -ForegroundColor Green
Write-Host "Note: if Claude MCP entries were added through the Claude CLI, remove them manually if you no longer want them." -ForegroundColor Yellow
