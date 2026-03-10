param(
  [ValidateSet("Menu", "Install", "Verify", "Uninstall")]
  [string]$Action = "Menu",
  [ValidateSet("general-use", "websites", "simple-apps")]
  [string]$Profile = "websites",
  [switch]$AutoRun,
  [switch]$Headless
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$starterPackRoot = Join-Path $repoRoot "starter-pack"
$nextStepsPath = Join-Path $repoRoot "WHAT-TO-DO-NEXT.txt"

function Get-OperationSpec {
  param(
    [string]$CurrentAction,
    [string]$CurrentProfile
  )

  switch ($CurrentAction) {
    "Install" {
      return @{
        Title = "Installing Starter Pack 2026"
        ScriptPath = (Join-Path $starterPackRoot "INSTALL.ps1")
        Arguments = @("-Profile", $CurrentProfile)
      }
    }
    "Verify" {
      return @{
        Title = "Checking Starter Pack 2026"
        ScriptPath = (Join-Path $starterPackRoot "VERIFY.ps1")
        Arguments = @("-Profile", $CurrentProfile)
      }
    }
    "Uninstall" {
      return @{
        Title = "Removing Starter Pack 2026"
        ScriptPath = (Join-Path $starterPackRoot "UNINSTALL.ps1")
        Arguments = @()
      }
    }
    default {
      throw "Unknown action: $CurrentAction"
    }
  }
}

function Invoke-HeadlessOperation {
  param(
    [string]$CurrentAction,
    [string]$CurrentProfile
  )

  $spec = Get-OperationSpec -CurrentAction $CurrentAction -CurrentProfile $CurrentProfile
  $headlessArgs = @(
    "-NoProfile",
    "-ExecutionPolicy",
    "Bypass",
    "-File",
    $spec.ScriptPath
  ) + @($spec.Arguments)

  & powershell @headlessArgs
  return $LASTEXITCODE
}

if ($Headless) {
  if ($Action -eq "Menu") {
    $Action = "Install"
  }
  exit (Invoke-HeadlessOperation -CurrentAction $Action -CurrentProfile $Profile)
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object System.Windows.Forms.Form
$form.Text = "Starter Pack 2026"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(900, 620)
$form.MinimumSize = New-Object System.Drawing.Size(900, 620)
$form.BackColor = [System.Drawing.Color]::FromArgb(16, 16, 16)
$form.ForeColor = [System.Drawing.Color]::FromArgb(145, 255, 145)
$form.Font = New-Object System.Drawing.Font("Consolas", 10)
$form.MaximizeBox = $false

$banner = New-Object System.Windows.Forms.Label
$banner.Text = "STARTER PACK 2026"
$banner.Font = New-Object System.Drawing.Font("Consolas", 24, [System.Drawing.FontStyle]::Bold)
$banner.ForeColor = [System.Drawing.Color]::FromArgb(255, 220, 120)
$banner.AutoSize = $true
$banner.Location = New-Object System.Drawing.Point(24, 18)
$form.Controls.Add($banner)

$subtitle = New-Object System.Windows.Forms.Label
$subtitle.Text = "Retro feel. One click. Ready for a first site or app."
$subtitle.Font = New-Object System.Drawing.Font("Consolas", 10)
$subtitle.ForeColor = [System.Drawing.Color]::FromArgb(170, 255, 170)
$subtitle.AutoSize = $true
$subtitle.Location = New-Object System.Drawing.Point(27, 60)
$form.Controls.Add($subtitle)

$heroText = New-Object System.Windows.Forms.Label
$heroText.Text = "This installs the default setup for Codex or Claude Code. You do not need to know code first. While it runs, read the short guide on the right."
$heroText.Font = New-Object System.Drawing.Font("Consolas", 10)
$heroText.ForeColor = [System.Drawing.Color]::FromArgb(210, 255, 210)
$heroText.Size = New-Object System.Drawing.Size(835, 38)
$heroText.Location = New-Object System.Drawing.Point(28, 94)
$form.Controls.Add($heroText)

$installButton = New-Object System.Windows.Forms.Button
$installButton.Text = "INSTALL NOW"
$installButton.Size = New-Object System.Drawing.Size(260, 58)
$installButton.Location = New-Object System.Drawing.Point(28, 148)
$installButton.FlatStyle = "Flat"
$installButton.BackColor = [System.Drawing.Color]::FromArgb(44, 44, 44)
$installButton.ForeColor = [System.Drawing.Color]::FromArgb(255, 240, 180)
$installButton.Font = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold)
$installButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(120, 255, 120)
$installButton.FlatAppearance.BorderSize = 1
$form.Controls.Add($installButton)

$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Ready. This installs everything in one pass."
$statusLabel.Font = New-Object System.Drawing.Font("Consolas", 10)
$statusLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 220, 120)
$statusLabel.AutoSize = $true
$statusLabel.Location = New-Object System.Drawing.Point(312, 168)
$form.Controls.Add($statusLabel)

$progress = New-Object System.Windows.Forms.ProgressBar
$progress.Location = New-Object System.Drawing.Point(28, 222)
$progress.Size = New-Object System.Drawing.Size(835, 16)
$progress.Style = "Continuous"
$progress.Visible = $false
$form.Controls.Add($progress)

$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Point(28, 254)
$outputBox.Size = New-Object System.Drawing.Size(430, 288)
$outputBox.Multiline = $true
$outputBox.ScrollBars = "Vertical"
$outputBox.ReadOnly = $true
$outputBox.BackColor = [System.Drawing.Color]::FromArgb(0, 0, 0)
$outputBox.ForeColor = [System.Drawing.Color]::FromArgb(120, 255, 120)
$outputBox.Font = New-Object System.Drawing.Font("Consolas", 10)
$outputBox.Text = @"
When you start the install:

- Starter Pack sets up Codex and Claude Code for first-project work.
- It installs the default build-ready baseline.
- It finishes by opening a plain-language next-step note.

You do not need to pick a profile.
You do not need a terminal.
"@
$form.Controls.Add($outputBox)

$guidePanel = New-Object System.Windows.Forms.Panel
$guidePanel.Location = New-Object System.Drawing.Point(482, 254)
$guidePanel.Size = New-Object System.Drawing.Size(381, 288)
$guidePanel.BackColor = [System.Drawing.Color]::FromArgb(22, 22, 22)
$guidePanel.BorderStyle = "FixedSingle"
$form.Controls.Add($guidePanel)

$guideTitle = New-Object System.Windows.Forms.Label
$guideTitle.Text = "WHAT TO DO AFTER INSTALL"
$guideTitle.Font = New-Object System.Drawing.Font("Consolas", 12, [System.Drawing.FontStyle]::Bold)
$guideTitle.ForeColor = [System.Drawing.Color]::FromArgb(255, 220, 120)
$guideTitle.AutoSize = $true
$guideTitle.Location = New-Object System.Drawing.Point(14, 14)
$guidePanel.Controls.Add($guideTitle)

$guideText = New-Object System.Windows.Forms.Label
$guideText.Text = @"
1. Make one folder for your project.
   Example: My First Site

2. Open that folder in Codex or Claude Code.

3. Ask in plain language:
   Plan and build me a simple website.
   Or: Plan and build me a simple app.

4. Good habit:
   Ask the agent to plan first,
   then build step by step.

You do not need to understand code.
You can just describe what you want.
"@
$guideText.Font = New-Object System.Drawing.Font("Consolas", 10)
$guideText.ForeColor = [System.Drawing.Color]::FromArgb(210, 255, 210)
$guideText.Size = New-Object System.Drawing.Size(345, 236)
$guideText.Location = New-Object System.Drawing.Point(15, 46)
$guidePanel.Controls.Add($guideText)

$footer = New-Object System.Windows.Forms.Label
$footer.Text = "Install once. Then ask for a site, an app, a landing page, or a first project in normal language."
$footer.Font = New-Object System.Drawing.Font("Consolas", 9)
$footer.ForeColor = [System.Drawing.Color]::FromArgb(170, 255, 170)
$footer.Size = New-Object System.Drawing.Size(835, 32)
$footer.Location = New-Object System.Drawing.Point(28, 552)
$form.Controls.Add($footer)

$script:currentProcess = $null

$appendAction = [System.Action[string]]{
  param($line)
  if ([string]::IsNullOrWhiteSpace($line)) {
    return
  }
  $outputBox.AppendText($line + [Environment]::NewLine)
}

$finishAction = [System.Action[int, string]]{
  param($exitCode, $completedAction)

  $progress.Style = "Continuous"
  $progress.Visible = $false
  $installButton.Enabled = $true

  if ($exitCode -eq 0) {
    $statusLabel.Text = "$completedAction finished successfully."
    $outputBox.AppendText([Environment]::NewLine + "Done." + [Environment]::NewLine)
    try {
      [System.Media.SystemSounds]::Asterisk.Play()
    } catch {}

    if ($completedAction -eq "Install" -and (Test-Path $nextStepsPath)) {
      Start-Process notepad $nextStepsPath | Out-Null
    }
  } else {
    $statusLabel.Text = "$completedAction needs attention."
    $outputBox.AppendText([Environment]::NewLine + "Something needs attention." + [Environment]::NewLine)
    try {
      [System.Media.SystemSounds]::Hand.Play()
    } catch {}
  }

  $script:currentProcess = $null
}

function Start-UiOperation {
  param(
    [string]$CurrentAction,
    [string]$CurrentProfile
  )

  if ($script:currentProcess) {
    return
  }

  $spec = Get-OperationSpec -CurrentAction $CurrentAction -CurrentProfile $CurrentProfile
  $outputBox.Clear()
  $outputBox.AppendText($spec.Title + [Environment]::NewLine + [Environment]::NewLine)
  $outputBox.AppendText("You can relax while this runs." + [Environment]::NewLine)
  $outputBox.AppendText("You do not need to pick any profile or understand code first." + [Environment]::NewLine)
  $outputBox.AppendText("When install finishes, the next-step note opens automatically." + [Environment]::NewLine + [Environment]::NewLine)
  $statusLabel.Text = $spec.Title + "..."
  $progress.Style = "Marquee"
  $progress.MarqueeAnimationSpeed = 30
  $progress.Visible = $true
  $installButton.Enabled = $false

  $psi = New-Object System.Diagnostics.ProcessStartInfo
  $psi.FileName = "powershell"
  $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$($spec.ScriptPath)`" $($spec.Arguments -join ' ')"
  $psi.RedirectStandardOutput = $true
  $psi.RedirectStandardError = $true
  $psi.UseShellExecute = $false
  $psi.CreateNoWindow = $true

  $process = New-Object System.Diagnostics.Process
  $process.StartInfo = $psi
  $process.EnableRaisingEvents = $true

  $process.add_OutputDataReceived({
    if ($Event.SourceEventArgs.Data) {
      $form.BeginInvoke($appendAction, @($Event.SourceEventArgs.Data)) | Out-Null
    }
  })

  $process.add_ErrorDataReceived({
    if ($Event.SourceEventArgs.Data) {
      $form.BeginInvoke($appendAction, @($Event.SourceEventArgs.Data)) | Out-Null
    }
  })

  $process.add_Exited({
    $exitCode = $Event.Sender.ExitCode
    $form.BeginInvoke($finishAction, @($exitCode, $CurrentAction)) | Out-Null
  })

  $script:currentProcess = $process
  [void]$process.Start()
  $process.BeginOutputReadLine()
  $process.BeginErrorReadLine()
}

$installButton.Add_Click({ Start-UiOperation -CurrentAction "Install" -CurrentProfile "websites" })

$form.Add_Shown({
  try {
    [System.Media.SystemSounds]::Beep.Play()
    Start-Sleep -Milliseconds 100
    [System.Media.SystemSounds]::Asterisk.Play()
  } catch {}

  if ($AutoRun) {
    if ($Action -eq "Menu") {
      Start-UiOperation -CurrentAction "Install" -CurrentProfile $Profile
    } else {
      Start-UiOperation -CurrentAction $Action -CurrentProfile $Profile
    }
  }
})

[void]$form.ShowDialog()
