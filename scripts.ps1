#===============================================================================
# Custom Applications Installer - Add your own apps
# Created by: KARIM ABU RIDA
# Version: 1.0
# Description: Add any application manually and install it via winget
#===============================================================================

Clear-Host

# Store selected applications
$global:SelectedApps = @()

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
    Write-Host "              Custom Applications Installer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Add application to install list" -ForegroundColor Green
    Write-Host "   [2] Remove application from list" -ForegroundColor Red
    Write-Host "   [3] Show current list" -ForegroundColor Cyan
    Write-Host "   [4] Install all applications in list" -ForegroundColor Magenta
    Write-Host "   [5] Clear entire list" -ForegroundColor DarkRed
    Write-Host "   [6] Exit" -ForegroundColor Gray
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "           Currently selected: $($global:SelectedApps.Count) applications" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Add-Application {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Add Application to Install List" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Examples of winget IDs:" -ForegroundColor Yellow
    Write-Host "  - Google Chrome  : Google.Chrome" -ForegroundColor Gray
    Write-Host "  - Mozilla Firefox: Mozilla.Firefox" -ForegroundColor Gray
    Write-Host "  - Visual Studio  : Microsoft.VisualStudioCode" -ForegroundColor Gray
    Write-Host "  - 7-Zip          : 7zip.7zip" -ForegroundColor Gray
    Write-Host "  - Spotify        : Spotify.Spotify" -ForegroundColor Gray
    Write-Host "  - Discord        : Discord.Discord" -ForegroundColor Gray
    Write-Host "  - Telegram       : Telegram.TelegramDesktop" -ForegroundColor Gray
    Write-Host "  - Zoom           : Zoom.Zoom" -ForegroundColor Gray
    Write-Host "  - Slack          : Slack.Slack" -ForegroundColor Gray
    Write-Host "  - Git            : Git.Git" -ForegroundColor Gray
    Write-Host "  - Node.js        : OpenJS.NodeJS" -ForegroundColor Gray
    Write-Host "  - Python         : Python.Python" -ForegroundColor Gray
    Write-Host "  - Notepad++      : Notepad++.Notepad++" -ForegroundColor Gray
    Write-Host "  - VLC            : VideoLAN.VLC" -ForegroundColor Gray
    Write-Host "  - GIMP           : GIMP.GIMP" -ForegroundColor Gray
    Write-Host "  - Steam          : Valve.Steam" -ForegroundColor Gray
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $appName = Read-Host "Enter application name (for display)"
    $wingetId = Read-Host "Enter winget ID"
    
    if ($appName -and $wingetId) {
        $global:SelectedApps += [PSCustomObject]@{
            Name = $appName
            WingetId = $wingetId
        }
        Write-Host ""
        Write-Host "✓ Added: $appName ($wingetId)" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "✗ Failed to add application" -ForegroundColor Red
    }
    
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Remove-Application {
    if ($global:SelectedApps.Count -eq 0) {
        Write-Host ""
        Write-Host "List is empty! Nothing to remove." -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
        return
    }
    
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Remove Application from List" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    for ($i = 0; $i -lt $global:SelectedApps.Count; $i++) {
        Write-Host "   [$($i+1)] $($global:SelectedApps[$i].Name) ($($global:SelectedApps[$i].WingetId))" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "   [0] Cancel" -ForegroundColor Gray
    Write-Host ""
    
    $choice = Read-Host "Enter number to remove"
    if ($choice -match "^\d+$" -and [int]$choice -gt 0 -and [int]$choice -le $global:SelectedApps.Count) {
        $removed = $global:SelectedApps[[int]$choice - 1]
        $global:SelectedApps = $global:SelectedApps | Where-Object { $_ -ne $removed }
        Write-Host ""
        Write-Host "✓ Removed: $($removed.Name)" -ForegroundColor Green
    }
    
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Show-CurrentList {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Current Applications List" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    if ($global:SelectedApps.Count -eq 0) {
        Write-Host "   List is empty. Use option [1] to add applications." -ForegroundColor Yellow
    } else {
        Write-Host " Total: $($global:SelectedApps.Count) applications" -ForegroundColor Green
        Write-Host ""
        Write-Host " #   Application Name                    Winget ID" -ForegroundColor Cyan
        Write-Host "---  ---------------------------------  ---------------------------------" -ForegroundColor DarkGray
        
        for ($i = 0; $i -lt $global:SelectedApps.Count; $i++) {
            Write-Host " $($i+1)   $($global:SelectedApps[$i].Name.PadRight(35))" -NoNewline -ForegroundColor White
            Write-Host " $($global:SelectedApps[$i].WingetId)" -ForegroundColor Yellow
        }
    }
    
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Install-AllApplications {
    if ($global:SelectedApps.Count -eq 0) {
        Write-Host ""
        Write-Host "List is empty! Add applications first." -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
        return
    }
    
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installing Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Applications to install:" -ForegroundColor Yellow
    foreach ($app in $global:SelectedApps) {
        Write-Host "  - $($app.Name)" -ForegroundColor White
    }
    
    Write-Host ""
    $confirm = Read-Host "Proceed with installation? (y/n)"
    
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Installation cancelled." -ForegroundColor Red
        Read-Host "Press Enter to continue"
        return
    }
    
    Write-Host ""
    Write-Host "Starting installation..." -ForegroundColor Green
    Write-Host ""
    
    $successCount = 0
    $failCount = 0
    
    foreach ($app in $global:SelectedApps) {
        Write-Host ">>> Installing $($app.Name)..." -ForegroundColor Cyan
        winget install $app.WingetId --accept-package-agreements --accept-source-agreements --silent
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] $($app.Name) installed successfully!" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "[FAIL] Failed to install $($app.Name)" -ForegroundColor Red
            $failCount++
        }
        Write-Host ""
    }
    
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Installation completed!" -ForegroundColor Green
    Write-Host "Successful: $successCount | Failed: $failCount" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Clear-List {
    if ($global:SelectedApps.Count -eq 0) {
        Write-Host "List is already empty." -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
        return
    }
    
    Write-Host ""
    $confirm = Read-Host "Are you sure you want to clear all $($global:SelectedApps.Count) applications? (y/n)"
    
    if ($confirm -eq "y" -or $confirm -eq "Y") {
        $global:SelectedApps = @()
        Write-Host "List cleared successfully!" -ForegroundColor Green
    } else {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
    }
    
    Read-Host "Press Enter to continue"
}

# Main program loop
do {
    Show-MainMenu
    $choice = Read-Host "Enter your choice (1-6)"
    
    switch ($choice) {
        "1" { Add-Application }
        "2" { Remove-Application }
        "3" { Show-CurrentList }
        "4" { Install-AllApplications }
        "5" { Clear-List }
        "6" {
            Clear-Host
            Show-Signature
            Write-Host ""
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "                   Thank you for using Custom Installer!" -ForegroundColor White
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
            Write-Host "                         GitHub: MARKETTV1" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Exiting... Goodbye!" -ForegroundColor Green
            Write-Host ""
            Start-Sleep -Seconds 2
            break
        }
        default {
            Write-Host "Invalid choice! Please enter 1-6" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($choice -ne "6")
