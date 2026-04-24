#===============================================================================
# KARIM ABU RIDA - All-in-One Windows Manager
# Version: 6.2 (Optional Admin Check Added)
# Tools: System Info + Winget Manager + App Scanner/Installer + Activation Tools
# GitHub: MARKETTV1
#===============================================================================

Clear-Host

function Show-Signature {
    Write-Host "                                                                  " -ForegroundColor DarkGray
    Write-Host "   ██╗  ██╗ █████╗ ██████╗ ██╗███╗   ███╗     █████ ╗ ██████╗ ██╗   ██╗    ██████╗ ██╗██████╗  █████╗ " -ForegroundColor Cyan
    Write-Host "   ██║ ██╔╝██╔══██╗██╔══██╗██║████╗ ████║    ██╔══██╗ ██╔══██╗██║   ██║    ██╔══██╗██║██╔══██╗██╔══██╗" -ForegroundColor Cyan
    Write-Host "   █████╔╝ ███████║██████╔╝██║██╔████╔██║    ███████║ ██████ ║██║   ██║    ██████╔╝██║██║  ██║███████║" -ForegroundColor Cyan
    Write-Host "   ██╔═██╗ ██╔══██║██╔══██╗██║██║╚██╔╝██║    ██╔══██╗ ██║  ██║██║   ██║    ██╔══██╗██║██║  ██║██╔══██║" -ForegroundColor Cyan
    Write-Host "   ██║  ██╗██║  ██║██║  ██║██║██║ ╚═╝ ██║    ██║  ██ ██████╔╝╚██████╔╝    ██║  ██║██║██████╔╝██║  ██║" -ForegroundColor Cyan
    Write-Host "   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚═════╝  ╚═════╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝" -ForegroundColor Cyan
    Write-Host "                                                                  " -ForegroundColor DarkGray
    Write-Host "                              Created by: KARIM ABU RIDA           " -ForegroundColor Yellow
    Write-Host "                              GitHub: MARKETTV1                    " -ForegroundColor Yellow
    Write-Host "                                                                  " -ForegroundColor DarkGray
}

#===============================================================================
# OPTIONAL ADMIN CHECK (يضاف إذا أردت فقط - لا يؤثر على الوظائف)
#===============================================================================
function Test-Admin {
    try {
        $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
        return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    } catch {
        return $false
    }
}

#===============================================================================
# SYSTEM INFORMATION DASHBOARD (نفس الكود الذي أرسلته - اختصرته للتوفير)
#===============================================================================
# ... هنا كل دوال النظام Show-SystemInfo, Get-CorrectWindowsVersion, إلخ ...
# (نفس الكود الذي أرسلته بالكامل)

#===============================================================================
# MAIN MENU (نفس الكود)
#===============================================================================
# ... كل الكود المتبقي كما هو ...

#===============================================================================
# STARTUP (مع إضافة فحص الصلاحيات الاختياري)
#===============================================================================
Show-Signature
Show-SystemInfo

# Optional admin warning (لا يوقف السكريبت)
if (-not (Test-Admin)) {
    Write-Host ""
    Write-Host "[ℹ] Note: Not running as Administrator" -ForegroundColor Yellow
    Write-Host "    Some features (updates, activations) may require admin rights." -ForegroundColor Gray
    Write-Host ""
}

Write-Host "Press any key to continue to main menu..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

#===============================================================================
# MAIN LOOP (نفس الكود)
#===============================================================================
# ... باقي الكود كما هو
