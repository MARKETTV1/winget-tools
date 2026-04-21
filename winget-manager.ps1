#===============================================================================
# Winget Manager + IDM Activation - Integrated Tool
# Created by: KARIM ABU RIDA
# Version: 3.0
#===============================================================================

Clear-Host

function Show-Signature {
    Write-Host "                                                                  " -ForegroundColor DarkGray
    Write-Host "   ██╗  ██╗ █████╗ ██████╗ ██╗███╗   ███╗    █████╗ ██████╗ ██╗   ██╗    ██████╗ ██╗██████╗  █████╗ " -ForegroundColor Cyan
    Write-Host "   ██║ ██╔╝██╔══██╗██╔══██╗██║████╗ ████║    ██╔══██╗██╔══██╗██║   ██║    ██╔══██╗██║██╔══██╗██╔══██╗" -ForegroundColor Cyan
    Write-Host "   █████╔╝ ███████║██████╔╝██║██╔████╔██║    ██████╔╝██║  ██║██║   ██║    ██████╔╝██║██║  ██║███████║" -ForegroundColor Cyan
    Write-Host "   ██╔═██╗ ██╔══██║██╔══██╗██║██║╚██╔╝██║    ██╔══██╗██║  ██║██║   ██║    ██╔══██╗██║██║  ██║██╔══██║" -ForegroundColor Cyan
    Write-Host "   ██║  ██╗██║  ██║██║  ██║██║██║ ╚═╝ ██║    ██║  ██║██████╔╝╚██████╔╝    ██║  ██║██║██████╔╝██║  ██║" -ForegroundColor Cyan
    Write-Host "   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚═════╝  ╚═════╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝" -ForegroundColor Cyan
    Write-Host "                                                                  " -ForegroundColor DarkGray
    Write-Host "                              Created by: KARIM ABU RIDA           " -ForegroundColor Yellow
    Write-Host "                              GitHub: MARKETTV1                    " -ForegroundColor Yellow
    Write-Host "                                                                  " -ForegroundColor DarkGray
}

function Show-MainMenu {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              Winget Manager + IDM Activation - Integrated Tool" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Show all installed applications with versions" -ForegroundColor Green
    Write-Host "   [2] Check for available updates and update selectively" -ForegroundColor Green
    Write-Host "   [3] IDM Activation (Internet Download Manager)" -ForegroundColor Magenta
    Write-Host "   [4] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Run-IDMActivation {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   IDM Activation Script (IAS)" -ForegroundColor Magenta
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Downloading IAS script..." -ForegroundColor Yellow

    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $iasPath = "$env:TEMP\IAS.cmd"
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MARKETTV1/idm/refs/heads/main/IAS.cmd" -OutFile $iasPath -ErrorAction Stop
        Write-Host "Download complete! Launching..." -ForegroundColor Green
        Write-Host ""
        Start-Process cmd.exe -ArgumentList "/c `"$iasPath`"" -Verb RunAs -Wait
        Write-Host ""
        Write-Host "IDM Activation script finished." -ForegroundColor Green
    } catch {
        Write-Host ""
        Write-Host "[ERROR] Failed to download IAS script!" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }

    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

function Show-AllApps {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                All Installed Applications - Version Viewer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Loading applications... (please wait)" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[1] WINGET APPLICATIONS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host ""

    $wingetApps = winget list --accept-source-agreements 2>$null
    $appsList = @()
    $lines = $wingetApps -split "`n"
    $found = $false

    foreach ($line in $lines) {
        if ($line -match "^-+---") { $found = $true; continue }
        if ($found -and $line.Trim() -ne "") {
            $parts = $line -split '\s{2,}'
            if ($parts.Count -ge 2 -and $parts[0] -match "[a-zA-Z0-9]") {
                $appsList += [PSCustomObject]@{
                    Name    = $parts[1].Trim()
                    Version = if ($parts.Count -gt 2) { $parts[2].Trim() } else { "Unknown" }
                }
            }
        }
    }

    $displayedWinget = [Math]::Min(100, $appsList.Count)
    for ($i = 0; $i -lt $displayedWinget; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($appsList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($appsList[$i].Version)]" -ForegroundColor Yellow
    }
    if ($appsList.Count -gt 100) { Write-Host "... and $($appsList.Count - 100) more Winget apps" -ForegroundColor Gray }

    Write-Host ""
    Write-Host "Total: $($appsList.Count) applications" -ForegroundColor Green
    Write-Host ""

    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[2] MICROSOFT STORE APPS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host ""

    $storeApps = Get-AppxPackage | Sort-Object Name
    $storeList = $storeApps | ForEach-Object {
        [PSCustomObject]@{ Name = $_.Name; Version = if ($_.Version) { $_.Version } else { "Unknown" } }
    }

    $displayCount = [Math]::Min(50, $storeList.Count)
    for ($i = 0; $i -lt $displayCount; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($storeList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($storeList[$i].Version)]" -ForegroundColor Yellow
    }
    if ($storeList.Count -gt 50) { Write-Host "... and $($storeList.Count - 50) more Store apps" -ForegroundColor Gray }

    Write-Host ""
    Write-Host "Total: $($storeList.Count) applications" -ForegroundColor Green
    Write-Host ""

    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[3] TRADITIONAL APPLICATIONS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host ""

    $registryApps = @()
    $regPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    foreach ($path in $regPaths) {
        try {
            $apps = Get-ItemProperty $path -ErrorAction SilentlyContinue |
                    Where-Object { $_.DisplayName -and $_.DisplayName -notmatch "^KB\d" }
            foreach ($app in $apps) {
                $registryApps += [PSCustomObject]@{
                    Name    = $app.DisplayName
                    Version = if ($app.DisplayVersion) { $app.DisplayVersion } else { "Unknown" }
                }
            }
        } catch {}
    }
    $registryApps = $registryApps | Sort-Object Name -Unique

    $displayedReg = [Math]::Min(50, $registryApps.Count)
    for ($i = 0; $i -lt $displayedReg; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($registryApps[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($registryApps[$i].Version)]" -ForegroundColor Yellow
    }
    if ($registryApps.Count -gt 50) { Write-Host "... and $($registryApps.Count - 50) more applications" -ForegroundColor Gray }

    Write-Host ""
    Write-Host "Total: $($registryApps.Count) applications" -ForegroundColor Green
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "SUMMARY" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Winget Applications      : $($appsList.Count)" -ForegroundColor Yellow
    Write-Host "Store Apps               : $($storeList.Count)" -ForegroundColor Yellow
    Write-Host "Traditional Apps         : $($registryApps.Count)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "TOTAL INSTALLED          : $($appsList.Count + $storeList.Count + $registryApps.Count)" -ForegroundColor Green
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

function Update-Selective {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Selective Winget Update Manager" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Checking for available updates..." -ForegroundColor Yellow
    Write-Host ""

    $upgradeOutput = winget upgrade --accept-source-agreements 2>$null
    $lines = $upgradeOutput -split "`n"
    $appsList = @()
    $found = $false

    foreach ($line in $lines) {
        if ($line -match "^-+---") { $found = $true; continue }
        if ($found -and $line.Trim() -ne "") {
            $parts = $line -split '\s{2,}'
            if ($parts.Count -ge 4 -and $parts[0] -match "[a-zA-Z0-9]") {
                $appsList += [PSCustomObject]@{
                    Id               = $parts[0].Trim()
                    Name             = $parts[1].Trim()
                    CurrentVersion   = $parts[2].Trim()
                    AvailableVersion = $parts[3].Trim()
                }
            }
        }
    }

    if ($appsList.Count -eq 0) {
        Write-Host "No updates available!" -ForegroundColor Green
        Write-Host ""
        Read-Host "Press Enter to return to main menu"
        return
    }

    Write-Host "Available updates:" -ForegroundColor Green
    Write-Host ""
    for ($i = 0; $i -lt $appsList.Count; $i++) {
        Write-Host "[$($i+1)] " -NoNewline -ForegroundColor Cyan
        Write-Host "$($appsList[$i].Name) " -NoNewline -ForegroundColor White
        Write-Host "($($appsList[$i].CurrentVersion) -> $($appsList[$i].AvailableVersion))" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Options:" -ForegroundColor White
    Write-Host "  - Enter numbers: 1,2,3" -ForegroundColor Gray
    Write-Host "  - Type 'all' for everything" -ForegroundColor Gray
    Write-Host "  - Type 'menu' to return to main menu" -ForegroundColor Gray
    Write-Host ""

    $userInput = Read-Host "Your choice"
    if ($userInput -eq "menu") { return }

    $toUpdate = @()
    if ($userInput -eq "all") {
        $toUpdate = $appsList
    } else {
        foreach ($num in ($userInput -split ",")) {
            $n = [int]$num.Trim() - 1
            if ($n -ge 0 -and $n -lt $appsList.Count) { $toUpdate += $appsList[$n] }
        }
    }

    if ($toUpdate.Count -eq 0) {
        Write-Host "No valid selection!" -ForegroundColor Red
        Read-Host "Press Enter to return to main menu"
        return
    }

    Write-Host ""
    Write-Host "Selected apps to update:" -ForegroundColor Green
    foreach ($app in $toUpdate) { Write-Host "  - $($app.Name)" -ForegroundColor White }

    Write-Host ""
    $confirm = Read-Host "Proceed with update? (y/n)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Cancelled!" -ForegroundColor Red
        Read-Host "Press Enter to return to main menu"
        return
    }

    Write-Host ""
    Write-Host "Starting updates..." -ForegroundColor Yellow
    Write-Host ""

    foreach ($app in $toUpdate) {
        Write-Host ">>> Updating $($app.Name)..." -ForegroundColor Cyan
        winget upgrade $app.Id --accept-package-agreements --accept-source-agreements --silent
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] $($app.Name) updated successfully!" -ForegroundColor Green
        } else {
            Write-Host "[FAIL] Failed to update $($app.Name)" -ForegroundColor Red
        }
        Write-Host ""
    }

    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Update process completed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# ── Main Loop ──────────────────────────────────────────────────────────────────
do {
    Show-MainMenu
    $menuChoice = Read-Host "Enter your choice (1-4)"

    switch ($menuChoice) {
        "1" { Show-AllApps }
        "2" { Update-Selective }
        "3" { Run-IDMActivation }
        "4" {
            Clear-Host
            Show-Signature
            Write-Host ""
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "                   Thank you for using Winget Manager!" -ForegroundColor White
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
            Write-Host "                         GitHub: MARKETTV1" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Exiting... Goodbye!" -ForegroundColor Green
            Write-Host ""
            Start-Sleep -Seconds 3
            break
        }
        default {
            Write-Host "Invalid choice! Please enter 1, 2, 3, or 4" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($menuChoice -ne "4")
