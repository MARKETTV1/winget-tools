#===============================================================================
# Ninite Applications Installer - Latest Versions
# Created by: KARIM ABU RIDA
# Version: 1.0
# Description: Download and install latest versions of popular apps via Ninite
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

# Ninite application list with their codes
$NiniteApps = @(
    @{Name = "7-Zip"; Code = "7zip"; Category = "Utilities"},
    @{Name = "Google Chrome"; Code = "chrome"; Category = "Browsers"},
    @{Name = "Mozilla Firefox"; Code = "firefox"; Category = "Browsers"},
    @{Name = "Brave"; Code = "brave"; Category = "Browsers"},
    @{Name = "Discord"; Code = "discord"; Category = "Messaging"},
    @{Name = "Slack"; Code = "slack"; Category = "Messaging"},
    @{Name = "Telegram"; Code = "telegram"; Category = "Messaging"},
    @{Name = "Zoom"; Code = "zoom"; Category = "Video"},
    @{Name = "Spotify"; Code = "spotify"; Category = "Media"},
    @{Name = "VLC"; Code = "vlc"; Category = "Media"},
    @{Name = "GIMP"; Code = "gimp"; Category = "Graphics"},
    @{Name = "Paint.NET"; Code = "paintnet"; Category = "Graphics"},
    @{Name = "Visual Studio Code"; Code = "vscode"; Category = "Development"},
    @{Name = "Git"; Code = "git"; Category = "Development"},
    @{Name = "Node.js"; Code = "nodejs"; Category = "Development"},
    @{Name = "Python"; Code = "python"; Category = "Development"},
    @{Name = "Notepad++"; Code = "notepadplusplus"; Category = "Text"},
    @{Name = "LibreOffice"; Code = "libreoffice"; Category = "Office"},
    @{Name = "Adobe Reader"; Code = "adobereader"; Category = "Documents"},
    @{Name = "Foxit Reader"; Code = "foxitreader"; Category = "Documents"},
    @{Name = "Steam"; Code = "steam"; Category = "Games"},
    @{Name = "Epic Games Launcher"; Code = "epic"; Category = "Games"},
    @{Name = "Java Runtime"; Code = "java"; Category = "Runtimes"},
    @{Name = ".NET Runtime"; Code = "dotnet"; Category = "Runtimes"},
    @{Name = "Dropbox"; Code = "dropbox"; Category = "Cloud"},
    @{Name = "Google Drive"; Code = "googledrive"; Category = "Cloud"},
    @{Name = "TeamViewer"; Code = "teamviewer"; Category = "Remote"},
    @{Name = "qBittorrent"; Code = "qbittorrent"; Category = "Download"},
    @{Name = "FileZilla"; Code = "filezilla"; Category = "FTP"},
    @{Name = "KeePass"; Code = "keepass"; Category = "Security"}
)

function Show-MainMenu {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Ninite - Latest Applications Installer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Browse and select applications by category" -ForegroundColor Green
    Write-Host "   [2] Show all available applications" -ForegroundColor Green
    Write-Host "   [3] Download and install selected applications" -ForegroundColor Green
    Write-Host "   [4] Install pre-configured essentials pack" -ForegroundColor Green
    Write-Host "   [5] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Show-Categories {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Select Applications by Category" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $categories = $NiniteApps | Group-Object Category | Sort-Object Name
    $i = 1
    $categoryList = @{}
    
    foreach ($cat in $categories) {
        Write-Host "   [$i] $($cat.Name)" -ForegroundColor Green
        $categoryList[$i] = $cat.Name
        $i++
    }
    Write-Host ""
    Write-Host "   [0] Back to main menu" -ForegroundColor Gray
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    
    $choice = Read-Host "Enter your choice"
    if ($choice -eq "0") { return $null }
    
    if ($categoryList.ContainsKey([int]$choice)) {
        return $categoryList[[int]$choice]
    }
    return $null
}

function Show-AppsByCategory {
    param($CategoryName)
    
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Applications in: $CategoryName" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $apps = $NiniteApps | Where-Object { $_.Category -eq $CategoryName }
    $i = 1
    $selectedApps = @()
    
    foreach ($app in $apps) {
        Write-Host "   [$i] $($app.Name)" -ForegroundColor White
        $i++
    }
    Write-Host ""
    Write-Host "   [A] Select all" -ForegroundColor Green
    Write-Host "   [D] Done selecting" -ForegroundColor Green
    Write-Host "   [0] Back" -ForegroundColor Gray
    Write-Host ""
    
    while ($true) {
        $choice = Read-Host "Enter numbers (comma separated) or command"
        if ($choice -eq "0") { return @() }
        if ($choice -eq "A" -or $choice -eq "a") {
            $selectedApps = $apps | ForEach-Object { $_.Code }
            Write-Host "Selected all applications in this category!" -ForegroundColor Green
        }
        elseif ($choice -eq "D" -or $choice -eq "d") {
            break
        }
        else {
            $numbers = $choice -split ","
            foreach ($num in $numbers) {
                $idx = [int]$num.Trim() - 1
                if ($idx -ge 0 -and $idx -lt $apps.Count) {
                    if ($selectedApps -notcontains $apps[$idx].Code) {
                        $selectedApps += $apps[$idx].Code
                        Write-Host "Selected: $($apps[$idx].Name)" -ForegroundColor Green
                    }
                }
            }
        }
    }
    
    return $selectedApps
}

function Show-AllApps {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    All Available Applications" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " Code                          Application Name                    Category" -ForegroundColor Yellow
    Write-Host "--------------------------------------------------------------------------------" -ForegroundColor DarkGray
    
    foreach ($app in ($NiniteApps | Sort-Object Name)) {
        Write-Host " $($app.Code.PadRight(30))" -NoNewline -ForegroundColor Cyan
        Write-Host " $($app.Name.PadRight(35))" -NoNewline -ForegroundColor White
        Write-Host " $($app.Category)" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Read-Host "Press Enter to continue"
}

function Build-NiniteInstaller {
    param($SelectedCodes)
    
    if ($SelectedCodes.Count -eq 0) {
        Write-Host "No applications selected!" -ForegroundColor Red
        return $null
    }
    
    # Build Ninite URL
    $appsString = ($SelectedCodes -join ",")
    $niniteUrl = "https://ninite.com/$appsString/ninite.exe"
    
    $outputPath = "$env:TEMP\ninite_installer.exe"
    
    Write-Host ""
    Write-Host "Selected applications: $($SelectedCodes.Count)" -ForegroundColor Green
    Write-Host "Downloading Ninite installer..." -ForegroundColor Yellow
    
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $niniteUrl -OutFile $outputPath -UseBasicParsing
        Write-Host "Download complete!" -ForegroundColor Green
        return $outputPath
    } catch {
        Write-Host "Download failed: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

function Select-Applications {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Select Applications to Install" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $allSelected = @()
    
    do {
        $category = Show-Categories
        if ($category -eq $null) { break }
        
        $selected = Show-AppsByCategory -CategoryName $category
        $allSelected += $selected
        $allSelected = $allSelected | Select-Object -Unique
        
        Write-Host ""
        Write-Host "Currently selected: $($allSelected.Count) applications" -ForegroundColor Cyan
        
        $continue = Read-Host "Select another category? (y/n)"
    } while ($continue -eq "y")
    
    return $allSelected
}

function Run-NiniteInstaller {
    param($InstallerPath)
    
    if (-not $InstallerPath -or -not (Test-Path $InstallerPath)) {
        Write-Host "Installer not found!" -ForegroundColor Red
        return
    }
    
    Write-Host ""
    Write-Host "Starting Ninite installer..." -ForegroundColor Yellow
    Write-Host "Note: Ninite will automatically install the latest versions silently" -ForegroundColor Gray
    Write-Host "You can monitor the progress in the system tray" -ForegroundColor Gray
    Write-Host ""
    
    $confirm = Read-Host "Start installation? (y/n)"
    if ($confirm -eq "y") {
        Start-Process -FilePath $InstallerPath -Wait
        Write-Host ""
        Write-Host "Installation process completed!" -ForegroundColor Green
    }
}

function Install-Essentials {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Essentials Pack Installation" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "The essentials pack includes:" -ForegroundColor Yellow
    Write-Host "  - Google Chrome (Browser)" -ForegroundColor White
    Write-Host "  - Firefox (Browser)" -ForegroundColor White
    Write-Host "  - VLC (Media Player)" -ForegroundColor White
    Write-Host "  - 7-Zip (Archive Utility)" -ForegroundColor White
    Write-Host "  - Notepad++ (Text Editor)" -ForegroundColor White
    Write-Host "  - Discord (Chat)" -ForegroundColor White
    Write-Host "  - Spotify (Music)" -ForegroundColor White
    Write-Host "  - Visual Studio Code (Code Editor)" -ForegroundColor White
    Write-Host "  - Git (Version Control)" -ForegroundColor White
    Write-Host "  - qBittorrent (Download Manager)" -ForegroundColor White
    Write-Host ""
    
    $essentialsCodes = @("chrome", "firefox", "vlc", "7zip", "notepadplusplus", "discord", "spotify", "vscode", "git", "qbittorrent")
    
    $installer = Build-NiniteInstaller -SelectedCodes $essentialsCodes
    if ($installer) {
        Run-NiniteInstaller -InstallerPath $installer
    }
}

# Main program loop
do {
    Show-MainMenu
    $choice = Read-Host "Enter your choice (1-5)"
    
    switch ($choice) {
        "1" {
            $selectedApps = Select-Applications
            if ($selectedApps.Count -gt 0) {
                $installer = Build-NiniteInstaller -SelectedCodes $selectedApps
                if ($installer) {
                    Run-NiniteInstaller -InstallerPath $installer
                }
            }
        }
        "2" {
            Show-AllApps
        }
        "3" {
            $selectedApps = Select-Applications
            if ($selectedApps.Count -gt 0) {
                $installer = Build-NiniteInstaller -SelectedCodes $selectedApps
                if ($installer) {
                    Run-NiniteInstaller -InstallerPath $installer
                }
            }
        }
        "4" {
            Install-Essentials
        }
        "5" {
            Clear-Host
            Show-Signature
            Write-Host ""
            Write-Host "================================================================================" -ForegroundColor Cyan
            Write-Host "                   Thank you for using Ninite Installer!" -ForegroundColor White
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
            Write-Host "Invalid choice! Please enter 1-5" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($choice -ne "5")
