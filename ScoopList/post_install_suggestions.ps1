# Script: post_install_suggestions.ps1
# Purpose: Apply recommended registry entries and additional setup for Scoop-installed applications
# Based on analysis of Logs/ScoopImportLog.txt from the MyScoop repo

# -------------------------------------------
# 1. Everything - Add Context Menu Entry
# -------------------------------------------
# Import Everything's context menu registry settings.
# This enables the "Search with Everything" option in the right-click context menu.
$everythingRegPath = "D:\Software\PackageManagers\Scoop\apps\everything\current\install-context.reg"
if (Test-Path $everythingRegPath) {
    Write-Host "Importing Everything context menu registry entries..."
    reg import $everythingRegPath
}

# -------------------------------------------
# 2. PowerToys - Add Context Menu Option
# -------------------------------------------
# Adds PowerToys menu option to the context menu (requires PowerShell).
$powertoysScriptPath = "D:\Software\PackageManagers\Scoop\apps\powertoys\current\install-context.ps1"
if (Test-Path $powertoysScriptPath) {
    Write-Host "Adding PowerToys context menu option..."
    Invoke-Expression -Command $powertoysScriptPath
}

# -------------------------------------------
# 3. General Recommendations & Warnings
# -------------------------------------------
Write-Host "`nGeneral Recommendations:"
Write-Host "- If you encounter issues with Scoop's aria2c downloader, disable it:"
Write-Host "    scoop config aria2-enabled false"
Write-Host "- Many GUI apps create Start Menu shortcuts. If missing, check the Scoop 'shims' directory."
Write-Host "- Some portable apps (e.g., ImageGlass, paint.net, WizTree) persist config files. Back them up if needed."
Write-Host "- For RTSS (RivaTuner Statistics Server), consider installing 'msiafterburner' and 'vcredist2022' for full functionality."

# -------------------------------------------
# 4. Per-App Notes
# -------------------------------------------
Write-Host "`nPer-App Specific Notes:"
Write-Host "- ImageGlass: If the app fails, try cleaning 'D:\Software\PackageManagers\Scoop\apps\imageglass\current\igconfig.json'."
Write-Host "- npcap: Installs with a GUI prompt, no silent install switch."
Write-Host "- O&O RegEditor and O&O ShutUp10++: Settings are persisted in .ini files in their Scoop app folders."
Write-Host "- Some Sysinternals tools (Autoruns, Bginfo, etc.): Multiple shims created, check 'D:\Software\PackageManagers\Scoop\shims'."
Write-Host "- paint.net, WizTree: Config files are persisted in their app folders for portability."

# -------------------------------------------
# 5. Manual Steps (if needed)
# -------------------------------------------
Write-Host "`nManual Steps:"
Write-Host "- After running this script, restart Explorer if you added context menu items:"
Write-Host "    Stop-Process -Name 'explorer'"

# End of script