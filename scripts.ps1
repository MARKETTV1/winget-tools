#===============================================================================
# Advanced App Installer - Handles Admin issues
# Created by: KARIM ABU RIDA
#===============================================================================

Clear-Host

$AppsList = @(
    @{Num=1; Name="Google Chrome"; Id="Google.Chrome"; Admin=$true}
    @{Num=2; Name="Mozilla Firefox"; Id="Mozilla.Firefox"; Admin=$true}
    @{Num=3; Name="Brave Browser"; Id="Brave.Brave"; Admin=$true}
    @{Num=4; Name="Microsoft Edge"; Id="Microsoft.Edge"; Admin=$true}
    @{Num=5; Name="Visual Studio Code"; Id="Microsoft.VisualStudioCode"; Admin=$true}
    @{Num=6; Name="7-Zip"; Id="7zip.7zip"; Admin=$true}
    @{Num=7; Name="VLC Media Player"; Id="VideoLAN.VLC"; Admin=$true}
    @{Num=8; Name="Discord"; Id="Discord.Discord"; Admin=$false}
    @{Num=9; Name="Spotify"; Id="Spotify.Spotify"; Admin=$false}
    @{Num=10; Name="Telegram"; Id="Telegram.TelegramDesktop"; Admin=$false}
    @{Num=11; Name="Zoom"; Id="Zoom.Zoom"; Admin=$false}
    @{Num=12; Name="Slack"; Id="Slack.Slack"; Admin=$false}
    @{Num=13; Name="Git"; Id="Git.Git"; Admin=$true}
    @{Num=14; Name="Node.js"; Id="OpenJS.NodeJS"; Admin=$true}
    @{Num=15; Name="Python 3"; Id="Python.Python.3"; Admin=$true}
    @{Num=16; Name="Notepad++"; Id="Notepad++.Notepad++"; Admin=$true}
    @{Num=17; Name="GIMP"; Id="GIMP.GIMP"; Admin=$true}
    @{Num=18; Name="Steam"; Id="Valve.Steam"; Admin=$false}
    @{Num=19; Name="Epic Games"; Id="EpicGames.EpicGamesLauncher"; Admin=$false}
    @{Num=20; Name="OBS Studio"; Id="OBSProject.OBSStudio"; Admin=$true}
    @{Num=21; Name="Blender"; Id="BlenderFoundation.Blender"; Admin=$true}
    @{Num=22; Name="Adobe Reader"; Id="Adobe.Acrobat.Reader.64-bit"; Admin=$true}
    @{Num=23; Name="WinRAR"; Id="WinRAR.WinRAR"; Admin=$true}
    @{Num=24; Name="qBittorrent"; Id="qBittorrent.qBittorrent"; Admin=$true}
    @{Num=25; Name="FileZilla"; Id="FileZilla.Client.FTP"; Admin=$true}
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

function Install-App {
    param($App)
    
    Write-Host ">>> Installing $($App.Name)..." -ForegroundColor Cyan
    
    if ($App.Admin -eq $false) {
        # For apps that don't work with admin, run without elevation
        Write-Host "    (Running without admin privileges)" -ForegroundColor Gray
        $process = Start-Process -FilePath "winget" -ArgumentList "install $($App.Id) --accept-package-agreements --accept-source-agreements --silent" -Wait -NoNewWindow -PassThru
        $exitCode = $process.ExitCode
    } else {
        winget install $App.Id --accept-package-agreements --accept-source-agreements --silent
        $exitCode = $LASTEXITCODE
    }
    
    if ($exitCode -eq 0) {
        Write-Host "[✓] $($App.Name) installed successfully!" -ForegroundColor Green
        return $true
    } elseif ($exitCode -eq 1) {
        Write-Host "[!] $($App.Name) - Already installed or no update needed" -ForegroundColor Yellow
        return $true
    } else {
        Write-Host "[✗] Failed to install $($App.Name) (Error: $exitCode)" -ForegroundColor Red
        return $false
    }
}

function Show-AppsList {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Available Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  No.  Application Name                    (Admin Required)" -ForegroundColor Yellow
    Write-Host "  ---  -----------------------------------  ---------------" -ForegroundColor DarkGray
    
    foreach ($app in $AppsList) {
        $adminFlag = if ($app.Admin) { "✓ Yes" } else { "✗ No" }
        Write-Host "  $($app.Num)    $($app.Name.PadRight(35))  $adminFlag" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "  Note: Apps marked 'No' don't work well with admin privileges" -ForegroundColor Yellow
    Write-Host "        They will be installed without elevation" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

# Main menu
do {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              Advanced App Installer (Handles Admin Issues)" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Show all applications" -ForegroundColor Green
    Write-Host "   [2] Install application(s) by number" -ForegroundColor Cyan
    Write-Host "   [3] Install all (skip existing)" -ForegroundColor Magenta
    Write-Host "   [4] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "  Examples: 1,2,3  or  1 2 3  or  1,2,3,9,15" -ForegroundColor Gray
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
    
    $choice = Read-Host "`nEnter your choice (1-4)"
    
    switch ($choice) {
        "1" {
            Show-AppsList
            Read-Host "`nPress Enter to continue"
        }
        "2" {
            Show-AppsList
            Write-Host ""
            $input = Read-Host "Enter numbers (spaces or commas)"
            
            # Parse numbers
            $input = $input -replace " ", ","
            $selected = @()
            foreach ($num in ($input -split ",")) {
                $n = $num.Trim()
                if ($n -match "^\d+$") {
                    $app = $AppsList | Where-Object { $_.Num -eq [int]$n }
                    if ($app) { $selected += $app }
                }
            }
            
            if ($selected.Count -eq 0) {
                Write-Host "No valid numbers!" -ForegroundColor Red
                Read-Host "Press Enter"
                continue
            }
            
            Write-Host "`nSelected:" -ForegroundColor Green
            foreach ($app in $selected) { Write-Host "  - $($app.Name)" -ForegroundColor White }
            
            $confirm = Read-Host "`nInstall? (y/n)"
            if ($confirm -ne "y") { Write-Host "Cancelled." -ForegroundColor Red; Read-Host; continue }
            
            Write-Host "`nStarting installation...`n" -ForegroundColor Yellow
            
            $success = 0
            $fail = 0
            foreach ($app in $selected) {
                if (Install-App -App $app) { $success++ } else { $fail++ }
                Write-Host ""
            }
            
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "Completed: $success successful, $fail failed" -ForegroundColor $(if ($fail -eq 0) { "Green" } else { "Yellow" })
            Write-Host "================================================================================" -ForegroundColor Cyan
            Read-Host "`nPress Enter to continue"
        }
        "3" {
            Write-Host "`nInstalling all applications..." -ForegroundColor Yellow
            Write-Host "Note: Apps that don't work with admin will be handled separately`n" -ForegroundColor Gray
            
            $success = 0
            $fail = 0
            foreach ($app in $AppsList) {
                if (Install-App -App $app) { $success++ } else { $fail++ }
                Write-Host ""
            }
            
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "Completed: $success successful, $fail failed" -ForegroundColor $(if ($fail -eq 0) { "Green" } else { "Yellow" })
            Write-Host "================================================================================" -ForegroundColor Cyan
            Read-Host "`nPress Enter to continue"
        }
        "4" {
            Write-Host "Exiting... Goodbye!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "Invalid choice!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "4")
