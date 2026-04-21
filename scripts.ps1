#===============================================================================
# Advanced App Scanner - Check installed apps and latest versions
# Created by: KARIM ABU RIDA
# Version: 1.0
#===============================================================================

Clear-Host

# قائمة التطبيقات للمراقبة
$AppsToMonitor = @(
    @{Num=1; Name="Google Chrome"; WingetId="Google.Chrome"; Category="Browser"}
    @{Num=2; Name="Mozilla Firefox"; WingetId="Mozilla.Firefox"; Category="Browser"}
    @{Num=3; Name="Brave Browser"; WingetId="Brave.Brave"; Category="Browser"}
    @{Num=4; Name="Microsoft Edge"; WingetId="Microsoft.Edge"; Category="Browser"}
    @{Num=5; Name="Visual Studio Code"; WingetId="Microsoft.VisualStudioCode"; Category="Development"}
    @{Num=6; Name="7-Zip"; WingetId="7zip.7zip"; Category="Utilities"}
    @{Num=7; Name="VLC Media Player"; WingetId="VideoLAN.VLC"; Category="Media"}
    @{Num=8; Name="Discord"; WingetId="Discord.Discord"; Category="Communication"}
    @{Num=9; Name="Spotify"; WingetId="Spotify.Spotify"; Category="Media"}
    @{Num=10; Name="Telegram"; WingetId="Telegram.TelegramDesktop"; Category="Communication"}
    @{Num=11; Name="Zoom"; WingetId="Zoom.Zoom"; Category="Communication"}
    @{Num=12; Name="Slack"; WingetId="Slack.Slack"; Category="Communication"}
    @{Num=13; Name="Git"; WingetId="Git.Git"; Category="Development"}
    @{Num=14; Name="Node.js"; WingetId="OpenJS.NodeJS"; Category="Development"}
    @{Num=15; Name="Python"; WingetId="Python.Python.3"; Category="Development"}
    @{Num=16; Name="Notepad++"; WingetId="Notepad++.Notepad++"; Category="Text Editor"}
    @{Num=17; Name="GIMP"; WingetId="GIMP.GIMP"; Category="Graphics"}
    @{Num=18; Name="Steam"; WingetId="Valve.Steam"; Category="Gaming"}
    @{Num=19; Name="Epic Games"; WingetId="EpicGames.EpicGamesLauncher"; Category="Gaming"}
    @{Num=20; Name="OBS Studio"; WingetId="OBSProject.OBSStudio"; Category="Streaming"}
    @{Num=21; Name="Blender"; WingetId="BlenderFoundation.Blender"; Category="3D"}
    @{Num=22; Name="Adobe Reader"; WingetId="Adobe.Acrobat.Reader.64-bit"; Category="PDF"}
    @{Num=23; Name="WinRAR"; WingetId="WinRAR.WinRAR"; Category="Utilities"}
    @{Num=24; Name="qBittorrent"; WingetId="qBittorrent.qBittorrent"; Category="Download"}
    @{Num=25; Name="FileZilla"; WingetId="FileZilla.Client.FTP"; Category="FTP"}
    @{Num=26; Name="TeamViewer"; WingetId="TeamViewer.TeamViewer"; Category="Remote"}
    @{Num=27; Name="Putty"; WingetId="PuTTY.PuTTY"; Category="Network"}
    @{Num=28; Name="Wireshark"; WingetId="WiresharkFoundation.Wireshark"; Category="Network"}
    @{Num=29; Name="VirtualBox"; WingetId="Oracle.VirtualBox"; Category="Virtualization"}
    @{Num=30; Name="Docker Desktop"; WingetId="Docker.DockerDesktop"; Category="Development"}
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

function Get-InstalledVersion {
    param($WingetId)
    try {
        $result = winget list --id $WingetId --accept-source-agreements 2>$null
        $lines = $result -split "`n"
        foreach ($line in $lines) {
            if ($line -match "$WingetId\s+(\S+)") {
                return $matches[1]
            }
        }
    } catch {}
    return "غير مثبت"
}

function Get-LatestVersion {
    param($WingetId)
    try {
        $result = winget show $WingetId --accept-source-agreements 2>$null
        if ($result -match "Version:\s*(\S+)") {
            return $matches[1]
        }
    } catch {}
    return "غير معروف"
}

function Compare-Versions {
    param($Installed, $Latest)
    
    if ($Installed -eq "غير مثبت") { return "NOT_INSTALLED" }
    if ($Latest -eq "غير معروف") { return "UNKNOWN" }
    if ($Installed -eq $Latest) { return "UPDATED" }
    
    # مقارنة بسيطة للأرقام
    $installedParts = $Installed -split '\.'
    $latestParts = $Latest -split '\.'
    
    for ($i = 0; $i -lt [Math]::Min($installedParts.Length, $latestParts.Length); $i++) {
        $instNum = [int]$installedParts[$i]
        $latNum = [int]$latestParts[$i]
        if ($latNum -gt $instNum) { return "UPDATE_AVAILABLE" }
        if ($instNum -gt $latNum) { return "NEWER_THAN_LATEST" }
    }
    
    if ($latestParts.Length -gt $installedParts.Length) { return "UPDATE_AVAILABLE" }
    if ($installedParts.Length -gt $latestParts.Length) { return "NEWER_THAN_LATEST" }
    
    return "UPDATED"
}

function Get-StatusText {
    param($Status)
    switch ($Status) {
        "NOT_INSTALLED" { return @{Text="[غير مثبت]"; Color="DarkGray"} }
        "UPDATE_AVAILABLE" { return @{Text="[تحديث متاح]"; Color="Yellow"} }
        "UPDATED" { return @{Text="[محدث]"; Color="Green"} }
        "NEWER_THAN_LATEST" { return @{Text="[أحدث من المتاح]"; Color="Cyan"} }
        default { return @{Text="[غير معروف]"; Color="Red"} }
    }
}

function Scan-System {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    Scanning System for Installed Apps" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "This may take a few moments... (requires internet for latest versions)" -ForegroundColor Yellow
    Write-Host ""
    
    $results = @()
    $total = $AppsToMonitor.Count
    $current = 0
    
    foreach ($app in $AppsToMonitor) {
        $current++
        Write-Progress -Activity "Scanning applications..." -Status "$($app.Name)" -PercentComplete (($current / $total) * 100)
        
        $installed = Get-InstalledVersion -WingetId $app.WingetId
        $latest = Get-LatestVersion -WingetId $app.WingetId
        $status = Compare-Versions -Installed $installed -Latest $latest
        
        $results += [PSCustomObject]@{
            Num = $app.Num
            Name = $app.Name
            Category = $app.Category
            Installed = $installed
            Latest = $latest
            Status = $status
        }
    }
    
    Write-Progress -Activity "Scanning applications..." -Completed
    
    # عرض النتائج
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                    System Scan Results" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    # إحصائيات
    $stats = @{
        Installed = ($results | Where-Object { $_.Installed -ne "غير مثبت" }).Count
        NotInstalled = ($results | Where-Object { $_.Installed -eq "غير مثبت" }).Count
        UpdatesAvailable = ($results | Where-Object { $_.Status -eq "UPDATE_AVAILABLE" }).Count
        UpToDate = ($results | Where-Object { $_.Status -eq "UPDATED" }).Count
    }
    
    Write-Host "📊 STATISTICS:" -ForegroundColor Magenta
    Write-Host "   ✅ Installed Apps      : $($stats.Installed)" -ForegroundColor Green
    Write-Host "   ❌ Not Installed Apps  : $($stats.NotInstalled)" -ForegroundColor DarkGray
    Write-Host "   🔄 Updates Available   : $($stats.UpdatesAvailable)" -ForegroundColor Yellow
    Write-Host "   ✓ Up to Date           : $($stats.UpToDate)" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    # عرض حسب الفئة
    $categories = $results | Group-Object Category | Sort-Object Name
    
    foreach ($cat in $categories) {
        Write-Host "┌─ $($cat.Name) ─────────────────────────────────────────────────────────" -ForegroundColor Magenta
        
        foreach ($app in ($cat.Group | Sort-Object Name)) {
            $statusInfo = Get-StatusText -Status $app.Status
            
            # رقم التطبيق
            Write-Host "│ [$($app.Num)] " -NoNewline -ForegroundColor Cyan
            
            # اسم التطبيق
            Write-Host "$($app.Name.PadRight(22))" -NoNewline -ForegroundColor White
            
            # الإصدار المثبت
            if ($app.Installed -ne "غير مثبت") {
                Write-Host " Installed: $($app.Installed.PadRight(15))" -NoNewline -ForegroundColor Gray
            } else {
                Write-Host " Installed: -----------" -NoNewline -ForegroundColor DarkGray
            }
            
            # أحدث إصدار
            Write-Host " Latest: $($app.Latest.PadRight(15))" -NoNewline -ForegroundColor Green
            
            # الحالة
            Write-Host " $($statusInfo.Text)" -ForegroundColor $statusInfo.Color
        }
        Write-Host "└─────────────────────────────────────────────────────────────────────────" -ForegroundColor Magenta
        Write-Host ""
    }
    
    return $results
}

function Show-MainMenu {
    Clear-Host
    Show-Signature
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "              Advanced App Scanner & Installer" -ForegroundColor White
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   [1] Scan system and show all apps with versions" -ForegroundColor Green
    Write-Host "   [2] Show only apps with available updates" -ForegroundColor Yellow
    Write-Host "   [3] Show only installed apps" -ForegroundColor Cyan
    Write-Host "   [4] Show only missing apps" -ForegroundColor DarkGray
    Write-Host "   [5] Install apps by number" -ForegroundColor Magenta
    Write-Host "   [6] Update all outdated apps" -ForegroundColor Yellow
    Write-Host "   [7] Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "                         Developed by: KARIM ABU RIDA" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Cyan
}

# المتغيرات العامة
$global:ScanResults = $null

do {
    Show-MainMenu
    $choice = Read-Host "`nEnter your choice (1-7)"
    
    switch ($choice) {
        "1" {
            $global:ScanResults = Scan-System
            Read-Host "`nPress Enter to continue"
        }
        "2" {
            if ($null -eq $global:ScanResults) {
                Write-Host "Please scan first (option 1)" -ForegroundColor Yellow
                Read-Host "Press Enter"
                continue
            }
            $updates = $global:ScanResults | Where-Object { $_.Status -eq "UPDATE_AVAILABLE" }
            if ($updates.Count -eq 0) {
                Write-Host "`nNo updates available! All apps are up to date." -ForegroundColor Green
            } else {
                Write-Host "`n📦 Apps with available updates ($($updates.Count)):`n" -ForegroundColor Yellow
                foreach ($app in $updates) {
                    Write-Host "   [$($app.Num)] $($app.Name)" -ForegroundColor White
                    Write-Host "       Installed: $($app.Installed) → Latest: $($app.Latest)" -ForegroundColor Gray
                }
            }
            Read-Host "`nPress Enter to continue"
        }
        "3" {
            if ($null -eq $global:ScanResults) {
                Write-Host "Please scan first (option 1)" -ForegroundColor Yellow
                Read-Host "Press Enter"
                continue
            }
            $installed = $global:ScanResults | Where-Object { $_.Installed -ne "غير مثبت" }
            Write-Host "`n✅ Installed apps ($($installed.Count)):`n" -ForegroundColor Green
            foreach ($app in $installed) {
                Write-Host "   [$($app.Num)] $($app.Name) - Version: $($app.Installed)" -ForegroundColor White
            }
            Read-Host "`nPress Enter to continue"
        }
        "4" {
            if ($null -eq $global:ScanResults) {
                Write-Host "Please scan first (option 1)" -ForegroundColor Yellow
                Read-Host "Press Enter"
                continue
            }
            $missing = $global:ScanResults | Where-Object { $_.Installed -eq "غير مثبت" }
            Write-Host "`n❌ Missing apps ($($missing.Count)):`n" -ForegroundColor DarkGray
            foreach ($app in $missing) {
                Write-Host "   [$($app.Num)] $($app.Name)" -ForegroundColor White
            }
            Read-Host "`nPress Enter to continue"
        }
        "5" {
            if ($null -eq $global:ScanResults) {
                Write-Host "Please scan first (option 1)" -ForegroundColor Yellow
                Read-Host "Press Enter"
                continue
            }
            Write-Host "`nEnter numbers of apps to install (e.g., 1,2,3 or 1 2 3)" -ForegroundColor Gray
            $input = Read-Host "Numbers"
            
            $input = $input -replace " ", ","
            $selected = @()
            foreach ($num in ($input -split ",")) {
                $n = $num.Trim()
                if ($n -match "^\d+$") {
                    $app = $global:ScanResults | Where-Object { $_.Num -eq [int]$n }
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
            
            $confirm = Read-Host "`nInstall selected apps? (y/n)"
            if ($confirm -ne "y") { Write-Host "Cancelled." -ForegroundColor Red; Read-Host; continue }
            
            Write-Host "`nInstalling...`n" -ForegroundColor Yellow
            foreach ($app in $selected) {
                Write-Host ">>> Installing $($app.Name)..." -ForegroundColor Cyan
                winget install $app.WingetId --accept-package-agreements --accept-source-agreements --silent
                if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq 1 -or $LASTEXITCODE -eq -1978335189) {
                    Write-Host "[✓] Done!" -ForegroundColor Green
                } else {
                    Write-Host "[✗] Failed!" -ForegroundColor Red
                }
                Write-Host ""
            }
            # إعادة المسح بعد التثبيت
            $global:ScanResults = Scan-System
            Read-Host "Press Enter to continue"
        }
        "6" {
            if ($null -eq $global:ScanResults) {
                Write-Host "Please scan first (option 1)" -ForegroundColor Yellow
                Read-Host "Press Enter"
                continue
            }
            $toUpdate = $global:ScanResults | Where-Object { $_.Status -eq "UPDATE_AVAILABLE" }
            if ($toUpdate.Count -eq 0) {
                Write-Host "`nNo updates available!" -ForegroundColor Green
                Read-Host "Press Enter"
                continue
            }
            
            Write-Host "`nApps to update ($($toUpdate.Count)):" -ForegroundColor Yellow
            foreach ($app in $toUpdate) {
                Write-Host "  - $($app.Name): $($app.Installed) → $($app.Latest)" -ForegroundColor White
            }
            
            $confirm = Read-Host "`nUpdate all? (y/n)"
            if ($confirm -ne "y") { Write-Host "Cancelled." -ForegroundColor Red; Read-Host; continue }
            
            Write-Host "`nUpdating...`n" -ForegroundColor Yellow
            foreach ($app in $toUpdate) {
                Write-Host ">>> Updating $($app.Name)..." -ForegroundColor Cyan
                winget upgrade $app.WingetId --accept-package-agreements --accept-source-agreements --silent
                Write-Host ""
            }
            # إعادة المسح بعد التحديث
            $global:ScanResults = Scan-System
            Read-Host "Press Enter to continue"
        }
        "7" {
            Write-Host "Exiting... Goodbye!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "Invalid choice!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "7")
