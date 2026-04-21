#===============================================================================
# One-Click App Installer - Latest Versions via Winget
# Created by: KARIM ABU RIDA
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

# List of applications (add more as needed)
$AppsToInstall = @(
    @{Name = "Mozilla Firefox"; WingetId = "Mozilla.Firefox"; Description = "Web Browser"},
    @{Name = "Google Chrome"; WingetId = "Google.Chrome"; Description = "Web Browser"},
    @{Name = "Brave Browser"; WingetId = "Brave.Brave"; Description = "Web Browser"},
    @{Name = "Visual Studio Code"; WingetId = "Microsoft.VisualStudioCode"; Description = "Code Editor"},
    @{Name = "7-Zip"; WingetId = "7zip.7zip"; Description = "File Archiver"},
    @{Name = "VLC Media Player"; WingetId = "VideoLAN.VLC"; Description = "Media Player"},
    @{Name = "Discord"; WingetId = "Discord.Discord"; Description = "Chat & Voice"},
    @{Name = "Spotify"; WingetId = "Spotify.Spotify"; Description = "Music Streaming"},
    @{Name = "Notepad++"; WingetId = "Notepad++.Notepad++"; Description = "Text Editor"},
    @{Name = "Git"; WingetId = "Git.Git"; Description = "Version Control"},
    @{Name = "Node.js"; WingetId = "OpenJS.NodeJS"; Description = "JavaScript Runtime"},
    @{Name = "Python"; WingetId = "Python.Python"; Description = "Programming Language"},
    @{Name = "Telegram"; WingetId = "Telegram.TelegramDesktop"; Description = "Messaging"},
    @{Name = "Zoom"; WingetId = "Zoom.Zoom"; Description = "Video Conferencing"},
    @{Name = "Slack"; WingetId = "Slack.Slack"; Description = "Team Communication"},
    @{Name = "Steam"; WingetId = "Valve.Steam"; Description = "Gaming Platform"},
    @{Name = "Epic Games Launcher"; WingetId = "EpicGames.EpicGamesLauncher"; Description = "Game Store"},
    @{Name = "OBS Studio"; WingetId = "OBSProject.OBSStudio"; Description = "Streaming/Recording"},
    @{Name = "GIMP"; WingetId = "GIMP.GIMP"; Description = "Image Editor"},
    @{Name = "Blender"; WingetId = "BlenderFoundation.Blender"; Description = "3D Creation"}
)

function Show-MainMenu {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    One-Click App Installer (via Winget)" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Install Firefox (Web Browser)" -ForegroundColor Green
    Write-Host "   [2] Install all essential applications" -ForegroundColor Cyan
    Write-Host "   [3] Choose applications to install (selection menu)" -ForegroundColor Magenta
    Write-Host "   [4] Add custom application (by winget ID)" -ForegroundColor Yellow
    Write-Host "   [5] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Install-Firefox {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installing Mozilla Firefox" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Downloading and installing the latest version of Firefox..." -ForegroundColor Yellow
    Write-Host ""
    
    winget install Mozilla.Firefox --accept-package-agreements --accept-source-agreements
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ Firefox installed successfully!" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "✗ Installation failed. Please check your internet connection." -ForegroundColor Red
    }
    
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Install-Essentials {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installing Essential Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $essentials = @("Mozilla.Firefox", "Google.Chrome", "7zip.7zip", "VideoLAN.VLC", "Notepad++.Notepad++")
    
    Write-Host "The following applications will be installed:" -ForegroundColor Yellow
    Write-Host "  - Mozilla Firefox" -ForegroundColor White
    Write-Host "  - Google Chrome" -ForegroundColor White
    Write-Host "  - 7-Zip" -ForegroundColor White
    Write-Host "  - VLC Media Player" -ForegroundColor White
    Write-Host "  - Notepad++" -ForegroundColor White
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
    
    foreach ($appId in $essentials) {
        $app = $AppsToInstall | Where-Object { $_.WingetId -eq $appId }
        $appName = if ($app) { $app.Name } else { $appId }
        
        Write-Host ">>> Installing $appName..." -ForegroundColor Cyan
        winget install $appId --accept-package-agreements --accept-source-agreements --silent
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] $appName installed!" -ForegroundColor Green
        } else {
            Write-Host "[FAIL] Failed to install $appName" -ForegroundColor Red
        }
        Write-Host ""
    }
    
    Write-Host "Installation completed!" -ForegroundColor Green
    Read-Host "Press Enter to continue"
}

function Choose-Applications {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Select Applications to Install" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $selectedApps = @()
    $i = 1
    
    foreach ($app in $AppsToInstall) {
        Write-Host "   [$i] $($app.Name) - $($app.Description)" -ForegroundColor White
        $i++
    }
    
    Write-Host ""
    Write-Host "   [0] Start installation" -ForegroundColor Green
    Write-Host "   [A] Select all" -ForegroundColor Cyan
    Write-Host "   [C] Cancel" -ForegroundColor Red
    Write-Host ""
    
    $choice = Read-Host "Enter numbers (comma separated) or command"
    
    if ($choice -eq "C" -or $choice -eq "c") {
        return
    }
    
    if ($choice -eq "A" -or $choice -eq "a") {
        $selectedApps = $AppsToInstall
    } else {
        $numbers = $choice -split ","
        foreach ($num in $numbers) {
            $idx = [int]$num.Trim() - 1
            if ($idx -ge 0 -and $idx -lt $AppsToInstall.Count) {
                $selectedApps += $AppsToInstall[$idx]
            }
        }
    }
    
    if ($selectedApps.Count -eq 0) {
        Write-Host "No applications selected!" -ForegroundColor Red
        Read-Host "Press Enter to continue"
        return
    }
    
    Write-Host ""
    Write-Host "Selected applications: $($selectedApps.Count)" -ForegroundColor Green
    foreach ($app in $selectedApps) {
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
    
    foreach ($app in $selectedApps) {
        Write-Host ">>> Installing $($app.Name)..." -ForegroundColor Cyan
        winget install $app.WingetId --accept-package-agreements --accept-source-agreements --silent
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] $($app.Name) installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "[FAIL] Failed to install $($app.Name)" -ForegroundColor Red
        }
        Write-Host ""
    }
    
    Write-Host "Installation completed!" -ForegroundColor Green
    Read-Host "Press Enter to continue"
}

function Add-CustomApp {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Install Custom Application" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Examples of winget IDs:" -ForegroundColor Yellow
    Write-Host "  - Google Chrome  : Google.Chrome" -ForegroundColor Gray
    Write-Host "  - Mozilla Firefox: Mozilla.Firefox" -ForegroundColor Gray
    Write-Host "  - Visual Studio  : Microsoft.VisualStudioCode" -ForegroundColor Gray
    Write-Host ""
    Write-Host "To find a winget ID, use: winget search 'application name'" -ForegroundColor Cyan
    Write-Host ""
    
    $wingetId = Read-Host "Enter winget ID"
    
    if (-not $wingetId) {
        Write-Host "No ID provided!" -ForegroundColor Red
        Read-Host "Press Enter to continue"
        return
    }
    
    Write-Host ""
    Write-Host "Installing $wingetId..." -ForegroundColor Yellow
    Write-Host ""
    
    winget install $wingetId --accept-package-agreements --accept-source-agreements
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ Application installed successfully!" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "✗ Installation failed. Check the winget ID and try again." -ForegroundColor Red
    }
    
    Read-Host "Press Enter to continue"
}

# Main menu loop
do {
    Show-MainMenu
    $choice = Read-Host "Enter your choice (1-5)"
    
    switch ($choice) {
        "1" { Install-Firefox }
        "2" { Install-Essentials }
        "3" { Choose-Applications }
        "4" { Add-CustomApp }
        "5" { 
            Write-Host "Exiting... Goodbye!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "Invalid choice! Please enter 1-5" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($choice -ne "5")
