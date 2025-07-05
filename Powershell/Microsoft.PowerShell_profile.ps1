# =============== Water's PowerShell Profile (2024+, eza/exa-aware, portable) ===============
# Minimal, colorful, nerdy, portable, modern, with eza-first directory listings

# --- 1. oh-my-posh prompt: autodetect and setup ---
function Get-OhMyPoshExe {
    $possible = @(
        "D:\Software\PackageManagers\Scoop\shims\oh-my-posh.exe",
        "D:\Software\PackageManagers\Scoop\apps\oh-my-posh\current\oh-my-posh.exe",
        "$env:USERPROFILE\scoop\shims\oh-my-posh.exe",
        "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\JanDeDobbeleer.OhMyPosh_Microsoft.Winget.Source_8wekyb3d8bbwe\oh-my-posh.exe",
        "$env:ProgramFiles\oh-my-posh\bin\oh-my-posh.exe",
        "F:\Media\Documents\Powershell\oh-my-posh.exe",
        "oh-my-posh.exe"  # Fallback to PATH
    )
    foreach ($p in $possible) { if (Test-Path $p) { return $p } }
    return $null
}
$ThemeDirectory = "D:\Software\PackageManagers\Scoop\apps\oh-my-posh\current\themes\"
$DefaultTheme = "bubbles.omp.json"
$ThemePath = Join-Path $ThemeDirectory $DefaultTheme
$OMP_EXE = Get-OhMyPoshExe
if ($OMP_EXE) {
    & $OMP_EXE init pwsh --config $ThemePath | Invoke-Expression
} else {
    Write-Host "⚠️ oh-my-posh.exe not found! Please install via scoop, winget, or manually." -ForegroundColor Yellow
}

# --- 2. Modules: Load utility modules if present ---
foreach ($mod in @('PSReadLine','posh-git','Terminal-Icons','PSFzf','BurntToast')) {
    try { Import-Module $mod -ErrorAction SilentlyContinue } catch {}
}

# --- 3. Directory Listings: eza > exa > Get-ChildItem logic ---
# This block ensures you always get the "best available" modern listing!
if (Get-Command eza.exe -ErrorAction SilentlyContinue) {
    Set-Alias ls eza.exe
    Set-Alias ll 'eza.exe -l --icons'
    Set-Alias la 'eza.exe -la --icons'
    function lsd { eza.exe -d --icons }
    $env:LS_DEFAULT="eza"
} elseif (Get-Command exa.exe -ErrorAction SilentlyContinue) {
    Set-Alias ls exa.exe
    Set-Alias ll 'exa.exe -l --icons'
    Set-Alias la 'exa.exe -la --icons'
    function lsd { exa.exe -d --icons }
    $env:LS_DEFAULT="exa"
} else {
    Set-Alias ls Get-ChildItem
    Set-Alias ll 'Get-ChildItem -Force'
    Set-Alias la 'Get-ChildItem -Force -Hidden'
    function lsd { Get-ChildItem -Directory }
    $env:LS_DEFAULT="Get-ChildItem"
}

# --- 4. Syntax Highlighting and Prediction (PSReadLine) ---
if ($PSVersionTable.PSVersion.Major -ge 7) {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -Colors @{
        "Command" = "#8be9fd"
        "Parameter" = "#ffb86c"
        "String" = "#f1fa8c"
        "Operator" = "#bd93f9"
        "Variable" = "#50fa7b"
    }
} else {
    Set-PSReadLineOption -PredictionSource History
}

# --- 5. Fuzzy Finder (PSFzf) ---
if (Get-Command Invoke-Fzf -ErrorAction SilentlyContinue) {
    Set-Alias fzf Invoke-Fzf
    if (Get-Command Invoke-FzfHistory -ErrorAction SilentlyContinue) {
        Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock { Invoke-FzfHistory }
    }
}

# --- 6. Toast Notifications ---
function Show-Notify($Title, $Body) { try { New-BurntToastNotification -Text $Title, $Body } catch {} }

# --- 7. Quality-of-life Aliases and Helpers ---
Set-Alias gs Get-Service
Set-Alias e Edit-Profile
Set-Alias profile Edit-Profile
function Edit-Profile { notepad $PROFILE }

# --- 8. Sudo (gsudo) if installed ---
if (Get-Command gsudo -ErrorAction SilentlyContinue) { Set-Alias sudo gsudo }

# --- 9. Welcome Message ---
if ($host.Name -notlike "*VS*") {
    Write-Host "Welcome, $env:USERNAME! PowerShell ready 🚀 using $env:LS_DEFAULT for ls/ll/la/lsd" -ForegroundColor Cyan
}

# --- 10. Quick System Info ---
function sysinfo {
    Write-Host "System: $env:COMPUTERNAME ($env:USERNAME)" -ForegroundColor Green
    Write-Host "OS: $((Get-CimInstance Win32_OperatingSystem).Caption) $((Get-CimInstance Win32_OperatingSystem).Version)"
    Write-Host "Memory: $([Math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2)) GB"
    Write-Host "CPU: $((Get-CimInstance Win32_Processor).Name)"
}

# --- 11. Git Repo Status shortcut (gst) ---
if (Get-Command Get-GitStatus -ErrorAction SilentlyContinue) { function gst { Get-GitStatus } }

# --- 12. Portable Extras Support ---
$PortablePSFolder = "F:\Media\Documents\Powershell\Profile"
if (Test-Path "$PortablePSFolder\extras.ps1") { . "$PortablePSFolder\extras.ps1" }

# --- 13. Add Portable Bin folder to PATH ---
$PortableBin = "F:\Media\Documents\Powershell\Bin"
if (Test-Path $PortableBin) { $env:PATH = "$PortableBin;$env:PATH" }

# --- 14. Print PowerShell Module Paths (for troubleshooting) ---
function pspaths {
    Write-Host "`nPowerShell module paths:" -ForegroundColor Magenta
    $env:PSModulePath -split ';' | ForEach-Object { Write-Host "  $_" }
    Write-Host ""
}

# --- 15. Export installed modules to CSV ---
function export-modules {
    Get-Module -ListAvailable | Select-Object Name,Version,ModuleBase |
        Sort-Object Name | Export-Csv -Path "$env:USERPROFILE\Desktop\InstalledModules.csv" -NoTypeInformation
    Write-Host "Exported module list to Desktop."
}

# --- 16. (Optional) GitHub CLI (gh) helpers ---
# if (Get-Command gh -ErrorAction SilentlyContinue) {
#     function ghme { gh repo view --web }
# }

# --- 17. Useful install reminders for fresh Windows setups (commented) ---
# scoop install oh-my-posh eza fzf bat gsudo navi
# Install-Module PSReadLine, posh-git, Terminal-Icons, PSFzf, BurntToast -Scope CurrentUser -Force

# =============== End of Water's PowerShell Profile ===============

