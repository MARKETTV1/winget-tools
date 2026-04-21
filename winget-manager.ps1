#===============================================================================
# Winget Manager - Integrated Tool
# Created by: KARIM ABU RIDA
# Version: 2.0
# Description: Show all installed apps and selectively update them using Winget
#===============================================================================

Clear-Host

# Display signature banner at startup
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
    Write-Host "                   Winget Manager - Integrated Tool" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Show all installed applications with versions" -ForegroundColor Green
    Write-Host "   [2] Check for available updates and update selectively" -ForegroundColor Green
    Write-Host "   [3] Exit" -ForegroundColor Green
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
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
    
    # Get all apps from winget
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[1] WINGET APPLICATIONS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host ""
    
    $wingetApps = winget list --accept-source-agreements 2>$null
    $appsList = @()
    $lines = $wingetApps -split "`n"
    $found = $false
    
    foreach ($line in $lines) {
        if ($line -match "^-+---") {
            $found = $true
            continue
        }
        if ($found -and $line.Trim() -ne "") {
            $parts = $line -split '\s{2,}'
            if ($parts.Count -ge 2 -and $parts[0] -match "[a-zA-Z0-9]") {
                $appName = $parts[1].Trim()
                $appVersion = if ($parts.Count -gt 2) { $parts[2].Trim() } else { "Unknown" }
                
                $appsList += [PSCustomObject]@{
                    Name = $appName
                    Version = $appVersion
                }
            }
        }
    }
    
    $counter = 1
    $maxDisplay = 100
    $displayedWinget = [Math]::Min($maxDisplay, $appsList.Count)
    
    for ($i = 0; $i -lt $displayedWinget; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($appsList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($appsList[$i].Version)]" -ForegroundColor Yellow
    }
    
    if ($appsList.Count -gt $maxDisplay) {
        Write-Host ""
        Write-Host "... and $($appsList.Count - $maxDisplay) more Winget apps" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "Total: $($appsList.Count) applications" -ForegroundColor Green
    Write-Host ""
    
    # Get Microsoft Store apps
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host "[2] MICROSOFT STORE APPS" -ForegroundColor Green
    Write-Host "----------------------------------------" -ForegroundColor Magenta
    Write-Host ""
    
    $storeApps = Get-AppxPackage | Sort-Object Name
    $storeList = @()
    
    foreach ($app in $storeApps) {
        $appVersion = if ($app.Version) { $app.Version } else { "Unknown" }
        $appName = if ($app.Name) { $app.Name } else { "Unknown" }
        
        $storeList += [PSCustomObject]@{
            Name = $appName
            Version = $appVersion
        }
    }
    
    $displayCount = [Math]::Min(50, $storeList.Count)
    for ($i = 0; $i -lt $displayCount; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($storeList[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($storeList[$i].Version)]" -ForegroundColor Yellow
    }
    
    if ($storeList.Count -gt 50) {
        Write-Host ""
        Write-Host "... and $($storeList.Count - 50) more Store apps" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "Total: $($storeList.Count) applications" -ForegroundColor Green
    Write-Host ""
    
    # Get traditional apps from registry
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
            $apps = Get-ItemProperty $path -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -and $_.DisplayName -notmatch "^KB\d" }
            foreach ($app in $apps) {
                $registryApps += [PSCustomObject]@{
                    Name = $app.DisplayName
                    Version = if ($app.DisplayVersion) { $app.DisplayVersion } else { "Unknown" }
                }
            }
        } catch {
            # Skip errors
        }
    }
    
    $registryApps = $registryApps | Sort-Object Name -Unique
    
    $displayLimit = 50
    $displayedReg = [Math]::Min($displayLimit, $registryApps.Count)
    
    for ($i = 0; $i -lt $displayedReg; $i++) {
        Write-Host "$($i+1)." -NoNewline -ForegroundColor Cyan
        Write-Host " $($registryApps[$i].Name)" -NoNewline -ForegroundColor White
        Write-Host " [Version: $($registryApps[$i].Version)]" -ForegroundColor Yellow
    }
    
    if ($registryApps.Count -gt $displayLimit) {
        Write-Host ""
        Write-Host "... and $($registryApps.Count - $displayLimit) more applications" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "Total: $($registryApps.Count) applications" -ForegroundColor Green
    
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
        if ($line -match "^-+---") {
            $found = $true
            continue
        }
        if ($found -and $line.Trim() -ne "") {
            $parts = $line -split '\s{2,}'
            if ($parts.Count -ge 4 -and $parts[0] -match "[a-zA-Z0-9]") {
                $appsList += [PSCustomObject]@{
                    Id = $parts[0].Trim()
                    Name = $parts[1].Trim()
                    CurrentVersion = $parts[2].Trim()
                    AvailableVersion = $parts[3].Trim()
                }
            }
        }
    }
    
    if ($appsList.Count -eq 0) {
        Write-Host ""
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
    
    $input = Read-Host "Your choice"
    
    if ($input -eq "menu") {
        return
    }
    
    $toUpdate = @()
    if ($input -eq "all") {
        $toUpdate = $appsList
    } else {
        $numbers = $input -split ","
        foreach ($num in $numbers) {
            $n = [int]$num - 1
            if ($n -ge 0 -and $n -lt $appsList.Count) {
                $toUpdate += $appsList[$n]
            }
        }
    }
    
    if ($toUpdate.Count -eq 0) {
        Write-Host ""
        Write-Host "No valid selection!" -ForegroundColor Red
        Read-Host "Press Enter to return to main menu"
        return
    }
    
    Write-Host ""
    Write-Host "Selected apps to update:" -ForegroundColor Green
    foreach ($app in $toUpdate) {
        Write-Host "  - $($app.Name)" -ForegroundColor White
    }
    
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

# Main program loop
do {
    Show-MainMenu
    $menuChoice = Read-Host "Enter your choice (1-3)"
    
    switch ($menuChoice) {
        "1" { Show-AllApps }
        "2" { Update-Selective }
        "3" { 
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
            Write-Host ""
            Write-Host "Invalid choice! Please enter 1, 2, or 3" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($menuChoice -ne "3")
