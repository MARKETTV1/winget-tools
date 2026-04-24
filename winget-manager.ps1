#===============================================================================
# Winget Manager + IDM Activation + Store Apps - Integrated Tool
# Created by: KARIM ABU RIDA
# Version: 4.0 (Improved & Secured)
#===============================================================================

Clear-Host

# Check for Administrator privileges
function Test-Admin {
    $currentUser = [Security.Principal.WindowsPrincipal]::GetCurrent([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Restart script as Administrator if needed
function Ensure-Admin {
    if (-not (Test-Admin)) {
        Write-Host "This script requires Administrator privileges!" -ForegroundColor Red
        Write-Host "Restarting as Administrator..." -ForegroundColor Yellow
        Start-Sleep -Seconds 2
        Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
        exit
    }
}

# Optional: Create System Restore Point
function Create-RestorePoint {
    try {
        Checkpoint-Computer -Description "Before Winget Updates" -RestorePointType MODIFY_SETTINGS -ErrorAction SilentlyContinue
        Write-Host "[OK] System restore point created." -ForegroundColor Green
    } catch {
        Write-Host "[WARN] Could not create restore point (feature might be disabled)." -ForegroundColor Yellow
    }
}

# Signature Display
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
    Write-Host "                              Version: 4.0 (Improved & Secured)    " -ForegroundColor Yellow
    Write-Host "                                                                  " -ForegroundColor DarkGray
}

# Main Menu
function Show-MainMenu {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              Winget Manager + IDM Activation + Store Apps - Tool" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Show all installed applications (Winget + Store + Traditional)" -ForegroundColor Green
    Write-Host "   [2] Check for available updates and update selectively" -ForegroundColor Green
    Write-Host "   [3] Install Telegram Desktop from Microsoft Store" -ForegroundColor Magenta
    Write-Host "   [4] IDM Activation (Internet Download Manager)" -ForegroundColor Magenta
    Write-Host "   [5] Export installed apps list to file" -ForegroundColor Yellow
    Write-Host "   [6] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

# Install Telegram Desktop
function Install-Telegram {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Installing Telegram Desktop from Microsoft Store" -ForegroundColor Magenta
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""

    # Check if winget is available
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "[ERROR] Winget is not installed. Please install App Installer from Microsoft Store first." -ForegroundColor Red
        Read-Host "Press Enter to return"
        return
    }

    Write-Host "Searching for Telegram Desktop in Microsoft Store..." -ForegroundColor Yellow
    Write-Host ""

    # Try to install using winget (Microsoft Store ID)
    try {
        $telegramId = "9nztwsqntd0s"  # Telegram Desktop ID from the link you provided
        Write-Host "Installing Telegram Desktop (ID: $telegramId)..." -ForegroundColor Cyan
        winget install "Telegram.TelegramDesktop" --accept-source-agreements --accept-package-agreements --silent
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "[SUCCESS] Telegram Desktop installed successfully!" -ForegroundColor Green
            Write-Host "You can find it in the Start Menu." -ForegroundColor White
        } else {
            # Fallback to Microsoft Store link
            Write-Host "[INFO] Trying alternative installation method..." -ForegroundColor Yellow
            Start-Process "ms-windows-store://pdp/?ProductId=9nztwsqntd0s"
            Write-Host "[INFO] Microsoft Store page opened. Please click 'Install' manually." -ForegroundColor Cyan
        }
    } catch {
        Write-Host "[ERROR] Failed to install Telegram Desktop: $_" -ForegroundColor Red
        Write-Host "You can manually install it from: https://apps.microsoft.com/detail/9NZTWSQNTD0S" -ForegroundColor Yellow
    }

    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# Improved Show-AllApps with progress bar
function Show-AllApps {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                All Installed Applications - Version Viewer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""

    # Winget Apps with progress
    Write-Host "Loading Winget applications..." -ForegroundColor Yellow
    $wingetRaw = winget list --accept-source-agreements 2>$null | Out-String -Stream
    $appsList = @()
    $inTable = $false
    
    foreach ($line in $wingetRaw) {
        if ($line -match "^-+---") { $inTable = $true; continue }
        if ($inTable -and $line.Trim() -ne "") {
            # Better parsing using regex
            if ($line -match "^\s*([^\s]+)\s+(.+?)\s+(\d+\.\d+[\d\.]*)\s+") {
                $appsList += [PSCustomObject]@{
                    Name    = $matches[2].Trim()
                    Version = $matches[3].Trim()
                }
            }
        }
    }

    Write-Host "Found $($appsList.Count) Winget applications" -ForegroundColor Green
    Write-Host ""
    
    # Display first 50 apps (limit for performance)
    $displayedWinget = [Math]::Min(50, $appsList.Count)
    for ($i = 0; $i -lt $displayedWinget; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($appsList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($appsList[$i].Version)]" -ForegroundColor Yellow
    }
    if ($appsList.Count -gt 50) { Write-Host "... and $($appsList.Count - 50) more Winget apps" -ForegroundColor Gray }

    # Store Apps
    Write-Host ""
    Write-Host "Loading Microsoft Store Apps..." -ForegroundColor Yellow
    $storeApps = Get-AppxPackage | Sort-Object Name
    $storeList = $storeApps | ForEach-Object {
        [PSCustomObject]@{ Name = $_.Name; Version = if ($_.Version) { $_.Version } else { "Unknown" } }
    }

    $displayCount = [Math]::Min(30, $storeList.Count)
    for ($i = 0; $i -lt $displayCount; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($storeList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($storeList[$i].Version)]" -ForegroundColor Yellow
    }
    if ($storeList.Count -gt 30) { Write-Host "... and $($storeList.Count - 30) more Store apps" -ForegroundColor Gray }

    # Traditional Registry Apps
    Write-Host ""
    Write-Host "Loading Traditional Applications (Registry)..." -ForegroundColor Yellow
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

    $displayedReg = [Math]::Min(30, $registryApps.Count)
    for ($i = 0; $i -lt $displayedReg; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($registryApps[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($registryApps[$i].Version)]" -ForegroundColor Yellow
    }
    if ($registryApps.Count -gt 30) { Write-Host "... and $($registryApps.Count - 30) more applications" -ForegroundColor Gray }

    # Summary
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
    Read-Host "Press Enter to return to main menu"
}

# Export function
function Export-AppList {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Export Installed Applications List" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $desktop = [Environment]::GetFolderPath("Desktop")
    $fileName = "InstalledApps_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    $filePath = Join-Path $desktop $fileName
    
    Write-Host "Exporting to: $filePath" -ForegroundColor Yellow
    Write-Host ""
    
    # Collect all apps
    $allApps = @()
    
    # Winget apps
    $wingetRaw = winget list --accept-source-agreements 2>$null | Out-String -Stream
    $allApps += "=== WINGET APPLICATIONS ==="
    $allApps += $wingetRaw
    $allApps += ""
    
    # Store apps
    $allApps += "=== MICROSOFT STORE APPS ==="
    $storeApps = Get-AppxPackage | Sort-Object Name | Select-Object Name, Version
    foreach ($app in $storeApps) {
        $allApps += "$($app.Name) - Version: $($app.Version)"
    }
    $allApps += ""
    
    # Registry apps
    $allApps += "=== TRADITIONAL APPLICATIONS ==="
    $registryApps = @()
    $regPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    foreach ($path in $regPaths) {
        $apps = Get-ItemProperty $path -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName }
        foreach ($app in $apps) {
            $allApps += "$($app.DisplayName) - Version: $($app.DisplayVersion)"
        }
    }
    
    # Save to file
    try {
        $allApps | Out-File -FilePath $filePath -Encoding UTF8
        Write-Host "[SUCCESS] Exported successfully to:" -ForegroundColor Green
        Write-Host "$filePath" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Do you want to open the file now? (y/n)" -ForegroundColor Yellow
        $openChoice = Read-Host
        if ($openChoice -eq "y" -or $openChoice -eq "Y") {
            Invoke-Item $filePath
        }
    } catch {
        Write-Host "[ERROR] Failed to export: $_" -ForegroundColor Red
    }
    
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# IDM Activation (Improved)
function Run-IDMActivation {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   IDM Activation Script (IAS)" -ForegroundColor Magenta
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "[WARNING] This will download and run an external script from GitHub." -ForegroundColor Yellow
    Write-Host "[WARNING] Make sure you trust the source: https://github.com/MARKETTV1/idm" -ForegroundColor Yellow
    Write-Host ""
    
    $confirm = Read-Host "Do you want to continue? (y/n)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Cancelled by user." -ForegroundColor Red
        Read-Host "Press Enter to return"
        return
    }
    
    Write-Host ""
    Write-Host "Downloading IAS script..." -ForegroundColor Yellow

    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $iasPath = "$env:TEMP\IAS.cmd"
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MARKETTV1/idm/refs/heads/main/IAS.cmd" -OutFile $iasPath -ErrorAction Stop
        Write-Host "Download complete! Launching..." -ForegroundColor Green
        Write-Host ""
        
        # Verify file exists and is not empty
        if ((Get-Item $iasPath).Length -gt 0) {
            Start-Process cmd.exe -ArgumentList "/c `"$iasPath`"" -Verb RunAs -Wait
            Write-Host ""
            Write-Host "IDM Activation script finished." -ForegroundColor Green
        } else {
            throw "Downloaded file is empty"
        }
    } catch {
        Write-Host ""
        Write-Host "[ERROR] Failed to download or run IAS script!" -ForegroundColor Red
        Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        Write-Host "You can manually download it from: https://raw.githubusercontent.com/MARKETTV1/idm/refs/heads/main/IAS.cmd" -ForegroundColor Yellow
    }

    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# Improved Update-Selective with restore point option
function Update-Selective {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Selective Winget Update Manager" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Offer to create restore point
    Write-Host "Do you want to create a system restore point before updating? (recommended)" -ForegroundColor Yellow
    $createRp = Read-Host "(y/n)"
    if ($createRp -eq "y" -or $createRp -eq "Y") {
        Create-RestorePoint
    }
    
    Write-Host ""
    Write-Host "Checking for available updates..." -ForegroundColor Yellow
    Write-Host ""

    $upgradeOutput = winget upgrade --accept-source-agreements 2>$null | Out-String -Stream
    $appsList = @()
    $inTable = $false

    foreach ($line in $upgradeOutput) {
        if ($line -match "^-+---") { $inTable = $true; continue }
        if ($inTable -and $line.Trim() -ne "") {
            # Improved parsing for winget upgrade output
            if ($line -match "^\s*([^\s]+)\s+(.+?)\s+(\d+\.\d+[\d\.]*)\s+(\d+\.\d+[\d\.]*)") {
                $appsList += [PSCustomObject]@{
                    Id               = $matches[1].Trim()
                    Name             = $matches[2].Trim()
                    CurrentVersion   = $matches[3].Trim()
                    AvailableVersion = $matches[4].Trim()
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

    $successCount = 0
    $failCount = 0
    
    foreach ($app in $toUpdate) {
        Write-Host ">>> Updating $($app.Name)..." -ForegroundColor Cyan
        $updateResult = winget upgrade $app.Id --accept-package-agreements --accept-source-agreements --silent 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] $($app.Name) updated successfully!" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "[FAIL] Failed to update $($app.Name)" -ForegroundColor Red
            Write-Host "Error: $updateResult" -ForegroundColor DarkRed
            $failCount++
        }
        Write-Host ""
    }

    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Update process completed!" -ForegroundColor Green
    Write-Host "Successful: $successCount | Failed: $failCount" -ForegroundColor White
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# ── Main Loop ──────────────────────────────────────────────────────────────────
# Ensure running as Administrator for critical operations
if (-not (Test-Admin)) {
    Write-Host "Some features (updates, IDM activation) require Administrator privileges." -ForegroundColor Yellow
    Write-Host "It's recommended to run this script as Administrator." -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        exit
    }
}

do {
    Show-MainMenu
    $menuChoice = Read-Host "Enter your choice (1-6)"

    switch ($menuChoice) {
        "1" { Show-AllApps }
        "2" { Update-Selective }
        "3" { Install-Telegram }
        "4" { Run-IDMActivation }
        "5" { Export-AppList }
        "6" {
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
            Write-Host "Invalid choice! Please enter 1, 2, 3, 4, 5, or 6" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($menuChoice -ne "6")
