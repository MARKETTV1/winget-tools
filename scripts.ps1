#===============================================================================
# Universal App Installer - Works with all installation methods
# Created by: KARIM ABU RIDA
# Version: 3.0
#===============================================================================

Clear-Host

# قائمة التطبيقات مع روابط مباشرة (بديل لـ winget)
$AppsList = @(
    @{Num=1; Name="Google Chrome"; WingetId="Google.Chrome"; 
      Url="https://dl.google.com/chrome/install/latest/chrome_installer.exe";
      SilentArg="/silent /install"}
    
    @{Num=2; Name="Mozilla Firefox"; WingetId="Mozilla.Firefox";
      Url="https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US";
      SilentArg="/S"}
    
    @{Num=3; Name="Brave Browser"; WingetId="Brave.Brave";
      Url="https://laptop-updates.brave.com/latest/winx64";
      SilentArg="/silent /install"}
    
    @{Num=4; Name="Microsoft Edge"; WingetId="Microsoft.Edge";
      Url="https://go.microsoft.com/fwlink/?linkid=2108834&Channel=Stable&language=en-us&Consent=1";
      SilentArg="/silent /install"}
    
    @{Num=5; Name="Visual Studio Code"; WingetId="Microsoft.VisualStudioCode";
      Url="https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user";
      SilentArg="/verysilent /suppressmsgboxes"}
    
    @{Num=6; Name="7-Zip"; WingetId="7zip.7zip";
      Url="https://www.7-zip.org/a/7z2409-x64.exe";
      SilentArg="/S"}
    
    @{Num=7; Name="VLC Media Player"; WingetId="VideoLAN.VLC";
      Url="https://get.videolan.org/vlc/last/win64/vlc-latest-win64.exe";
      SilentArg="/S"}
    
    @{Num=8; Name="Discord"; WingetId="Discord.Discord";
      Url="https://discord.com/api/download?platform=win";
      SilentArg="/S"}
    
    @{Num=9; Name="Spotify"; WingetId="Spotify.Spotify";
      Url="https://download.scdn.co/SpotifySetup.exe";
      SilentArg="/silent"}
    
    @{Num=10; Name="Telegram"; WingetId="Telegram.TelegramDesktop";
      Url="https://telegram.org/dl/desktop/win64";
      SilentArg="/VERYSILENT /SUPPRESSMSGBOXES"}
    
    @{Num=11; Name="Zoom"; WingetId="Zoom.Zoom";
      Url="https://zoom.us/client/latest/ZoomInstaller.exe";
      SilentArg="/silent"}
    
    @{Num=12; Name="Slack"; WingetId="Slack.Slack";
      Url="https://slack.com/ssb/download-win64";
      SilentArg="/S"}
    
    @{Num=13; Name="Git"; WingetId="Git.Git";
      Url="https://github.com/git-for-windows/git/releases/latest/download/Git-2.47.1-64-bit.exe";
      SilentArg="/VERYSILENT /NORESTART"}
    
    @{Num=14; Name="Node.js"; WingetId="OpenJS.NodeJS";
      Url="https://nodejs.org/dist/latest/node-v23.3.0-x64.msi";
      SilentArg="/quiet"}
    
    @{Num=15; Name="Python"; WingetId="Python.Python.3";
      Url="https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe";
      SilentArg="/quiet InstallAllUsers=1 PrependPath=1"}
    
    @{Num=16; Name="Notepad++"; WingetId="Notepad++.Notepad++";
      Url="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/latest/download/npp.8.7.5.Installer.x64.exe";
      SilentArg="/S"}
    
    @{Num=17; Name="Steam"; WingetId="Valve.Steam";
      Url="https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe";
      SilentArg="/S"}
    
    @{Num=18; Name="Epic Games"; WingetId="EpicGames.EpicGamesLauncher";
      Url="https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi";
      SilentArg="/quiet"}
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

function Download-And-Install {
    param($App)
    
    Write-Host ">>> Installing $($App.Name)..." -ForegroundColor Cyan
    
    # تحميل الملف
    $installer = "$env:TEMP\$($App.Name -replace ' ', '_')_installer.exe"
    if ($App.Url -match "\.msi$") {
        $installer = "$env:TEMP\$($App.Name -replace ' ', '_')_installer.msi"
    }
    
    Write-Host "    Downloading..." -ForegroundColor Gray
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $App.Url -OutFile $installer -UseBasicParsing -ErrorAction Stop
        Write-Host "    Download complete!" -ForegroundColor Gray
    } catch {
        Write-Host "[✗] Failed to download $($App.Name)" -ForegroundColor Red
        return $false
    }
    
    # تثبيت الملف
    Write-Host "    Installing..." -ForegroundColor Gray
    
    if ($installer -match "\.msi$") {
        $process = Start-Process "msiexec" -ArgumentList "/i `"$installer`" $($App.SilentArg) /norestart" -Wait -PassThru -NoNewWindow
    } else {
        $process = Start-Process $installer -ArgumentList $App.SilentArg -Wait -PassThru -NoNewWindow
    }
    
    # تنظيف
    Remove-Item $installer -Force -ErrorAction SilentlyContinue
    
    if ($process.ExitCode -eq 0) {
        Write-Host "[✓] $($App.Name) installed successfully!" -ForegroundColor Green
        return $true
    } else {
        Write-Host "[!] $($App.Name) may already be installed (Exit: $($process.ExitCode))" -ForegroundColor Yellow
        return $true
    }
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
        Write-Host "  $($app.Num)    $($app.Name)" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
}

# Main menu
do {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              Universal App Installer (Direct Download)" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Show all applications" -ForegroundColor Green
    Write-Host "   [2] Install application(s) by number" -ForegroundColor Cyan
    Write-Host "   [3] Install all applications" -ForegroundColor Magenta
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
            foreach ($app in $selected) { 
                Write-Host "  - $($app.Name)" -ForegroundColor White
            }
            
            $confirm = Read-Host "`nInstall? (y/n)"
            if ($confirm -ne "y") { Write-Host "Cancelled." -ForegroundColor Red; Read-Host; continue }
            
            Write-Host "`nStarting installation...`n" -ForegroundColor Yellow
            
            $success = 0
            $fail = 0
            foreach ($app in $selected) {
                if (Download-And-Install -App $app) { $success++ } else { $fail++ }
                Write-Host ""
            }
            
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "Completed: $success successful, $fail failed" -ForegroundColor $(if ($fail -eq 0) { "Green" } else { "Yellow" })
            Write-Host "================================================================================" -ForegroundColor Cyan
            Read-Host "`nPress Enter to continue"
        }
        "3" {
            Write-Host "`nInstalling all applications..." -ForegroundColor Yellow
            Write-Host "This may take a while...`n" -ForegroundColor Gray
            
            $success = 0
            $fail = 0
            foreach ($app in $AppsList) {
                if (Download-And-Install -App $app) { $success++ } else { $fail++ }
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
