#===============================================================================
# Winget Manager + IDM Activation + Store Apps - Integrated Tool
# Created by: KARIM ABU RIDA
# Version: 4.2 (Complete - باكتمال جميع التحسينات)
# GitHub: MARKETTV1
#===============================================================================

Clear-Host

# Check for Administrator privileges
function Test-Admin {
    $currentUser = [Security.Principal.WindowsPrincipal]::GetCurrent([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
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
    Write-Host "                              Version: 4.2 (Complete)              " -ForegroundColor Yellow
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
    Write-Host "   [1] Show all installed applications" -ForegroundColor Green
    Write-Host "   [2] Check for available updates and update selectively" -ForegroundColor Green
    Write-Host "   [3] Install Telegram Desktop (Multi-Source: Store + Official)" -ForegroundColor Magenta
    Write-Host "   [4] IDM Activation (Internet Download Manager)" -ForegroundColor Magenta
    Write-Host "   [5] Export installed apps list to file" -ForegroundColor Yellow
    Write-Host "   [6] Search for an application to install" -ForegroundColor Cyan
    Write-Host "   [7] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

# Show All Installed Applications
function Show-AllApps {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                All Installed Applications - Version Viewer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""

    # Winget Apps
    Write-Host "[1] WINGET APPLICATIONS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Loading..." -ForegroundColor Yellow
    
    $wingetApps = winget list --accept-source-agreements 2>$null
    $wingetApps | Write-Host
    
    Write-Host ""
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[2] MICROSOFT STORE APPS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host ""
    
    $storeApps = Get-AppxPackage | Sort-Object Name | Select-Object Name, Version
    $storeDisplay = $storeApps | Select-Object -First 50
    $storeDisplay | ForEach-Object { Write-Host "$($_.Name) [Version: $($_.Version)]" -ForegroundColor White }
    if ($storeApps.Count -gt 50) { Write-Host "... and $($storeApps.Count - 50) more Store apps" -ForegroundColor Gray }
    Write-Host ""
    Write-Host "Total Store Apps: $($storeApps.Count)" -ForegroundColor Green
    
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
    
    $registryDisplay = $registryApps | Select-Object -First 50
    foreach ($app in $registryDisplay) {
        Write-Host "$($app.Name) [Version: $($app.Version)]" -ForegroundColor White
    }
    if ($registryApps.Count -gt 50) { Write-Host "... and $($registryApps.Count - 50) more applications" -ForegroundColor Gray }
    Write-Host ""
    Write-Host "Total Traditional Apps: $($registryApps.Count)" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "SUMMARY" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Note: Winget count shown above | Store: $($storeApps.Count) | Traditional: $($registryApps.Count)" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
    
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# Update Selective - FIXED VERSION
function Update-Selective {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Selective Winget Update Manager" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Check if winget exists
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "[ERROR] Winget is not installed!" -ForegroundColor Red
        Write-Host "Please install 'App Installer' from Microsoft Store." -ForegroundColor Yellow
        Write-Host ""
        Read-Host "Press Enter to return to main menu"
        return
    }
    
    # Display available updates
    Write-Host "Checking for available updates..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Running: winget upgrade" -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor Gray
    
    $upgradeResult = winget upgrade --accept-source-agreements 2>&1
    $upgradeResult | ForEach-Object { Write-Host $_ }
    
    Write-Host "----------------------------------------" -ForegroundColor Gray
    Write-Host ""
    
    # User options
    Write-Host "What would you like to do?" -ForegroundColor Yellow
    Write-Host "  [A] Update ALL available applications" -ForegroundColor Green
    Write-Host "  [S] Select specific applications to update (by ID)" -ForegroundColor Cyan
    Write-Host "  [N] Return to main menu" -ForegroundColor Red
    Write-Host ""
    
    $updateChoice = Read-Host "Your choice (A/S/N)"
    
    switch ($updateChoice.ToUpper()) {
        "A" {
            Write-Host ""
            Write-Host "Updating ALL applications..." -ForegroundColor Yellow
            Write-Host ""
            
            winget upgrade --all --accept-package-agreements --accept-source-agreements --silent
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "[SUCCESS] All updates completed!" -ForegroundColor Green
            } else {
                Write-Host "[WARNING] Update process completed with some errors." -ForegroundColor Yellow
            }
        }
        
        "S" {
            Write-Host ""
            Write-Host "Enter the application IDs to update (separated by spaces)" -ForegroundColor Yellow
            Write-Host "Example: 7zip.7zip Google.Chrome Microsoft.WindowsTerminal" -ForegroundColor Gray
            Write-Host "You can find IDs in the list above (first column)" -ForegroundColor Gray
            Write-Host ""
            $appIds = Read-Host "Application IDs"
            
            if ([string]::IsNullOrWhiteSpace($appIds)) {
                Write-Host "No IDs entered. Returning to menu..." -ForegroundColor Red
                Read-Host "Press Enter"
                return
            }
            
            Write-Host ""
            Write-Host "Starting updates..." -ForegroundColor Yellow
            Write-Host ""
            
            $ids = $appIds -split " "
            $successCount = 0
            $failCount = 0
            
            foreach ($id in $ids) {
                if ([string]::IsNullOrWhiteSpace($id)) { continue }
                
                Write-Host ">>> Updating: $id" -ForegroundColor Cyan
                $result = winget upgrade $id --accept-package-agreements --accept-source-agreements --silent 2>&1
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "[OK] $id updated successfully!" -ForegroundColor Green
                    $successCount++
                } else {
                    Write-Host "[FAIL] Failed to update $id" -ForegroundColor Red
                    if ($result -match "not found") {
                        Write-Host "      (Application ID not found or already up to date)" -ForegroundColor DarkRed
                    }
                    $failCount++
                }
                Write-Host ""
            }
            
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "Update completed! Successful: $successCount | Failed: $failCount" -ForegroundColor White
        }
        
        "N" {
            Write-Host "Returning to main menu..." -ForegroundColor Yellow
            Read-Host "Press Enter"
            return
        }
        
        default {
            Write-Host "Invalid choice. Returning to menu..." -ForegroundColor Red
            Read-Host "Press Enter"
            return
        }
    }
    
    Write-Host ""
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# Install Telegram Desktop - Multi-Source (Microsoft Store + Official Website)
function Install-Telegram {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Installing Telegram Desktop" -ForegroundColor Magenta
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "[ERROR] Winget is not installed!" -ForegroundColor Red
        Write-Host "Please install 'App Installer' from Microsoft Store first." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Alternative: Download manually from: https://telegram.org/dl/desktop/win64" -ForegroundColor Cyan
        Read-Host "Press Enter to return"
        return
    }

    Write-Host "Choose installation source:" -ForegroundColor Yellow
    Write-Host "  [1] Microsoft Store (recommended for automatic updates)" -ForegroundColor Cyan
    Write-Host "  [2] Official Telegram website (direct download from telegram.org)" -ForegroundColor Green
    Write-Host "  [3] Cancel" -ForegroundColor Red
    Write-Host ""
    
    $sourceChoice = Read-Host "Your choice (1/2/3)"
    
    switch ($sourceChoice) {
        "1" {
            Write-Host ""
            Write-Host "Installing from Microsoft Store..." -ForegroundColor Yellow
            Write-Host ""
            
            # Try multiple IDs for reliability
            $telegramIds = @(
                "Telegram.TelegramDesktop",
                "9nztwsqntd0s"
            )
            
            $installed = $false
            foreach ($id in $telegramIds) {
                Write-Host "Trying ID: $id" -ForegroundColor Cyan
                $installResult = winget install $id --accept-source-agreements --accept-package-agreements --silent 2>&1
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host ""
                    Write-Host "[SUCCESS] Telegram Desktop installed successfully from Microsoft Store!" -ForegroundColor Green
                    $installed = $true
                    break
                }
            }
            
            if (-not $installed) {
                Write-Host ""
                Write-Host "[INFO] Opening Microsoft Store page as fallback..." -ForegroundColor Yellow
                Start-Process "ms-windows-store://pdp/?ProductId=9nztwsqntd0s"
                Write-Host "[INFO] Please click 'Install' in the Microsoft Store window." -ForegroundColor Cyan
            }
        }
        
        "2" {
            Write-Host ""
            Write-Host "Downloading from official Telegram website..." -ForegroundColor Yellow
            Write-Host ""
            
            $downloadUrl = "https://telegram.org/dl/desktop/win64"
            $installerPath = "$env:TEMP\Telegram_Setup.exe"
            
            try {
                Write-Host "Downloading installer from: $downloadUrl" -ForegroundColor Cyan
                
                # Use Invoke-WebRequest with TLS 1.2
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath -ErrorAction Stop
                
                # Verify download
                if ((Get-Item $installerPath -ErrorAction SilentlyContinue).Length -gt 1MB) {
                    Write-Host "[SUCCESS] Download complete! (Size: $([math]::Round((Get-Item $installerPath).Length/1MB, 2)) MB)" -ForegroundColor Green
                    Write-Host ""
                    Write-Host "Launching installer..." -ForegroundColor Yellow
                    Start-Process $installerPath -Wait
                    
                    Write-Host ""
                    Write-Host "[SUCCESS] Installation process completed!" -ForegroundColor Green
                    
                    # Cleanup
                    Remove-Item $installerPath -ErrorAction SilentlyContinue
                } else {
                    throw "Downloaded file is too small or corrupted"
                }
                
            } catch {
                Write-Host "[ERROR] Failed to download installer: $($_.Exception.Message)" -ForegroundColor Red
                Write-Host ""
                Write-Host "Please download manually from: $downloadUrl" -ForegroundColor Yellow
                Write-Host "Or use option 1 (Microsoft Store) instead." -ForegroundColor Cyan
            }
        }
        
        "3" {
            Write-Host "Installation cancelled." -ForegroundColor Red
        }
        
        default {
            Write-Host "Invalid choice. Installation cancelled." -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# IDM Activation
function Run-IDMActivation {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   IDM Activation Script (IAS)" -ForegroundColor Magenta
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "[WARNING] This will download and run an external script from GitHub." -ForegroundColor Yellow
    Write-Host "[WARNING] Source: https://github.com/MARKETTV1/idm" -ForegroundColor Yellow
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
        
        if ((Get-Item $iasPath -ErrorAction SilentlyContinue).Length -gt 0) {
            Write-Host "Download complete! Launching..." -ForegroundColor Green
            Write-Host ""
            Start-Process cmd.exe -ArgumentList "/c `"$iasPath`"" -Verb RunAs -Wait
            Write-Host ""
            Write-Host "IDM Activation script finished." -ForegroundColor Green
        } else {
            throw "Downloaded file is empty"
        }
    } catch {
        Write-Host ""
        Write-Host "[ERROR] Failed to download IAS script!" -ForegroundColor Red
        Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Red
    }

    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# Export App List
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
    
    $allApps = @()
    
    # Add header
    $allApps += "=" * 80
    $allApps += "INSTALLED APPLICATIONS REPORT"
    $allApps += "Generated by: KARIM ABU RIDA (GitHub: MARKETTV1)"
    $allApps += "Date: $(Get-Date)"
    $allApps += "Computer: $env:COMPUTERNAME"
    $allApps += "=" * 80
    $allApps += ""
    
    # Winget apps
    $allApps += "=== WINGET APPLICATIONS ==="
    $allApps += ""
    $wingetApps = winget list --accept-source-agreements 2>$null
    $allApps += $wingetApps
    $allApps += ""
    $allApps += "Total Winget Apps: $((winget list --accept-source-agreements 2>$null | Select-String -Pattern '[a-zA-Z]' | Measure-Object).Count)"
    $allApps += ""
    
    # Store apps
    $allApps += "=== MICROSOFT STORE APPS ==="
    $allApps += ""
    $storeApps = Get-AppxPackage | Sort-Object Name
    foreach ($app in $storeApps) {
        $allApps += "$($app.Name) - Version: $($app.Version)"
    }
    $allApps += ""
    $allApps += "Total Store Apps: $($storeApps.Count)"
    $allApps += ""
    
    # Registry apps
    $allApps += "=== TRADITIONAL APPLICATIONS (Registry) ==="
    $allApps += ""
    $registryApps = @{}
    $regPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    foreach ($path in $regPaths) {
        $apps = Get-ItemProperty $path -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName }
        foreach ($app in $apps) {
            if (-not $registryApps.ContainsKey($app.DisplayName)) {
                $registryApps[$app.DisplayName] = $app.DisplayVersion
            }
        }
    }
    foreach ($key in $registryApps.Keys | Sort-Object) {
        $allApps += "$key - Version: $($registryApps[$key])"
    }
    $allApps += ""
    $allApps += "Total Traditional Apps: $($registryApps.Count)"
    $allApps += ""
    $allApps += "=" * 80
    $allApps += "END OF REPORT"
    $allApps += "=" * 80
    
    # Save to file
    try {
        $allApps | Out-File -FilePath $filePath -Encoding UTF8
        Write-Host "[SUCCESS] Exported successfully!" -ForegroundColor Green
        Write-Host "File saved to: $filePath" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Do you want to open the file? (y/n)" -ForegroundColor Yellow
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

# Search for application to install
function Search-App {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                   Search for Applications to Install" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "[ERROR] Winget is not installed!" -ForegroundColor Red
        Read-Host "Press Enter to return"
        return
    }
    
    $searchTerm = Read-Host "Enter application name to search"
    
    if ([string]::IsNullOrWhiteSpace($searchTerm)) {
        Write-Host "No search term entered!" -ForegroundColor Red
        Read-Host "Press Enter to return"
        return
    }
    
    Write-Host ""
    Write-Host "Searching for: $searchTerm" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Running: winget search `"$searchTerm`"" -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor Gray
    
    $searchResult = winget search $searchTerm --accept-source-agreements
    $searchResult | Write-Host
    
    Write-Host "----------------------------------------" -ForegroundColor Gray
    Write-Host ""
    
    Write-Host "Do you want to install any of these applications?" -ForegroundColor Yellow
    $installChoice = Read-Host "(y/n)"
    
    if ($installChoice -eq "y" -or $installChoice -eq "Y") {
        Write-Host ""
        Write-Host "Enter the application ID to install (from the first column in search results)" -ForegroundColor Cyan
        Write-Host "Example: 7zip.7zip, Google.Chrome, Microsoft.WindowsTerminal" -ForegroundColor Gray
        Write-Host ""
        $appId = Read-Host "Application ID"
        
        if (-not [string]::IsNullOrWhiteSpace($appId)) {
            Write-Host ""
            Write-Host "Installing: $appId" -ForegroundColor Yellow
            winget install $appId --accept-source-agreements --accept-package-agreements
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Host "[SUCCESS] Application installed successfully!" -ForegroundColor Green
            } else {
                Write-Host ""
                Write-Host "[ERROR] Failed to install application." -ForegroundColor Red
            }
        } else {
            Write-Host "No ID entered. Installation cancelled." -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Read-Host "Press Enter to return to main menu"
}

# ── Main Loop ──────────────────────────────────────────────────────────────────
# Warning about Administrator privileges
if (-not (Test-Admin)) {
    Clear-Host
    Show-Signature
    Write-Host ""
    Write-Host "[WARNING] You are not running as Administrator!" -ForegroundColor Red
    Write-Host "Some features (updates, IDM activation, some installations) may not work properly." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Recommended: Close this window and run PowerShell as Administrator, then run this script again." -ForegroundColor Cyan
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        exit
    }
}

do {
    Show-MainMenu
    $menuChoice = Read-Host "Enter your choice (1-7)"

    switch ($menuChoice) {
        "1" { Show-AllApps }
        "2" { Update-Selective }
        "3" { Install-Telegram }
        "4" { Run-IDMActivation }
        "5" { Export-AppList }
        "6" { Search-App }
        "7" {
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
            Write-Host "Invalid choice! Please enter 1, 2, 3, 4, 5, 6, or 7" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($menuChoice -ne "7")
