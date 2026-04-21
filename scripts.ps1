#===============================================================================
# Applications Installer - Select by Number (Improved)
# Created by: KARIM ABU RIDA
# Version: 1.1
#===============================================================================

Clear-Host

# قائمة التطبيقات
$AppsList = @(
    @{Number = 1;  Name = "Google Chrome";           WingetId = "Google.Chrome"}
    @{Number = 2;  Name = "Mozilla Firefox";         WingetId = "Mozilla.Firefox"}
    @{Number = 3;  Name = "Brave Browser";           WingetId = "Brave.Brave"}
    @{Number = 4;  Name = "Microsoft Edge";          WingetId = "Microsoft.Edge"}
    @{Number = 5;  Name = "Visual Studio Code";      WingetId = "Microsoft.VisualStudioCode"}
    @{Number = 6;  Name = "7-Zip";                   WingetId = "7zip.7zip"}
    @{Number = 7;  Name = "VLC Media Player";        WingetId = "VideoLAN.VLC"}
    @{Number = 8;  Name = "Discord";                 WingetId = "Discord.Discord"}
    @{Number = 9;  Name = "Spotify";                 WingetId = "Spotify.Spotify"}
    @{Number = 10; Name = "Telegram";                WingetId = "Telegram.TelegramDesktop"}
    @{Number = 11; Name = "Zoom";                    WingetId = "Zoom.Zoom"}
    @{Number = 12; Name = "Slack";                   WingetId = "Slack.Slack"}
    @{Number = 13; Name = "Git";                     WingetId = "Git.Git"}
    @{Number = 14; Name = "Node.js";                 WingetId = "OpenJS.NodeJS"}
    @{Number = 15; Name = "Python";                  WingetId = "Python.Python"}
    @{Number = 16; Name = "Notepad++";               WingetId = "Notepad++.Notepad++"}
    @{Number = 17; Name = "GIMP";                    WingetId = "GIMP.GIMP"}
    @{Number = 18; Name = "Steam";                   WingetId = "Valve.Steam"}
    @{Number = 19; Name = "Epic Games Launcher";     WingetId = "EpicGames.EpicGamesLauncher"}
    @{Number = 20; Name = "OBS Studio";              WingetId = "OBSProject.OBSStudio"}
    @{Number = 21; Name = "Blender";                 WingetId = "BlenderFoundation.Blender"}
    @{Number = 22; Name = "Adobe Acrobat Reader";    WingetId = "Adobe.Acrobat.Reader.64-bit"}
    @{Number = 23; Name = "WinRAR";                  WingetId = "WinRAR.WinRAR"}
    @{Number = 24; Name = "qBittorrent";             WingetId = "qBittorrent.qBittorrent"}
    @{Number = 25; Name = "FileZilla";               WingetId = "FileZilla.Client.FTP"}
)

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

function Show-AppsList {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Available Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  No.  Application Name" -ForegroundColor Yellow
    Write-Host "  ---  ----------------------------------------" -ForegroundColor DarkGray
    
    foreach ($app in $AppsList) {
        Write-Host "  $($app.Number)    $($app.Name)" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Parse-Numbers {
    param($InputString)
    
    $numbers = @()
    
    # استبدال المسافات والفواصل العربية بفواصل إنجليزية
    $cleanInput = $InputString -replace " ", "," -replace "،", ","
    
    # تقسيم الإدخال
    $parts = $cleanInput -split ","
    
    foreach ($part in $parts) {
        $part = $part.Trim()
        if ($part -match "^\d+$") {
            $num = [int]$part
            if ($num -ge 1 -and $num -le $AppsList.Count) {
                $numbers += $num
            }
        }
    }
    
    return $numbers | Select-Object -Unique
}

function Install-ByNumbers {
    param($SelectedNumbers)
    
    $selectedApps = @()
    
    foreach ($num in $SelectedNumbers) {
        $app = $AppsList | Where-Object { $_.Number -eq $num }
        if ($app) {
            $selectedApps += $app
        }
    }
    
    if ($selectedApps.Count -eq 0) {
        Write-Host "No valid applications selected!" -ForegroundColor Red
        return $false
    }
    
    Write-Host ""
    Write-Host "Selected applications:" -ForegroundColor Green
    foreach ($app in $selectedApps) {
        Write-Host "  - $($app.Name)" -ForegroundColor White
    }
    
    Write-Host ""
    $confirm = Read-Host "Proceed with installation? (y/n)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Installation cancelled." -ForegroundColor Red
        return $false
    }
    
    Write-Host ""
    Write-Host "Starting installation..." -ForegroundColor Yellow
    Write-Host ""
    
    $successCount = 0
    $failCount = 0
    
    foreach ($app in $selectedApps) {
        Write-Host ">>> Installing $($app.Name)..." -ForegroundColor Cyan
        winget install $app.WingetId --accept-package-agreements --accept-source-agreements --silent
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[✓] $($app.Name) installed successfully!" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "[✗] Failed to install $($app.Name)" -ForegroundColor Red
            $failCount++
        }
        Write-Host ""
    }
    
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "Installation completed!" -ForegroundColor Green
    Write-Host "Successful: $successCount | Failed: $failCount" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
    
    return $true
}

function Install-EssentialsPack {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Installing Essential Pack" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $essentialsNumbers = @(1, 2, 5, 6, 7, 16)
    
    Write-Host "The following applications will be installed:" -ForegroundColor Yellow
    foreach ($num in $essentialsNumbers) {
        $app = $AppsList | Where-Object { $_.Number -eq $num }
        if ($app) {
            Write-Host "  - $($app.Name)" -ForegroundColor White
        }
    }
    
    Write-Host ""
    $confirm = Read-Host "Proceed with installation? (y/n)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Installation cancelled." -ForegroundColor Red
        Read-Host "Press Enter to continue"
        return
    }
    
    Install-ByNumbers -SelectedNumbers $essentialsNumbers
    Read-Host "Press Enter to continue"
}

function Show-MainMenu {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              Application Installer - Select by Number" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Show all applications" -ForegroundColor Green
    Write-Host "   [2] Install application(s) by number" -ForegroundColor Cyan
    Write-Host "   [3] Install essential pack" -ForegroundColor Magenta
    Write-Host "   [4] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "  Examples: 1,2,3  or  5  or  1,2,3,9,15  or  1 2 3 9 15 (spaces ok)" -ForegroundColor Gray
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

# Main loop
do {
    Show-MainMenu
    $choice = Read-Host "Enter your choice (1-4)"
    
    switch ($choice) {
        "1" {
            Show-AppsList
            Read-Host "Press Enter to continue"
        }
        "2" {
            Show-AppsList
            Write-Host ""
            Write-Host "You can write numbers separated by commas or spaces" -ForegroundColor Gray
            Write-Host "Examples: 1,2,3  or  1 2 3  or  1,2,3,9,15" -ForegroundColor Gray
            Write-Host ""
            $input = Read-Host "Enter numbers"
            
            $selectedNumbers = Parse-Numbers -InputString $input
            
            if ($selectedNumbers.Count -gt 0) {
                Install-ByNumbers -SelectedNumbers $selectedNumbers
            } else {
                Write-Host "No valid numbers entered!" -ForegroundColor Red
            }
            Read-Host "Press Enter to continue"
        }
        "3" {
            Install-EssentialsPack
        }
        "4" {
            Clear-Host
            Show-Signature
            Write-Host ""
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "                   Thank you for using App Installer!" -ForegroundColor White
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Exiting... Goodbye!" -ForegroundColor Green
            Write-Host ""
            Start-Sleep -Seconds 2
            break
        }
        default {
            Write-Host "Invalid choice! Please enter 1-4" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($choice -ne "4")
