# Script: post_install_suggestions.ps1
# Purpose: Apply recommended registry entries and additional setup for Scoop-installed applications
# Based on analysis of Logs/ScoopImportLog.txt from the MyScoop repo

# -------------------------------------------
# 1. Everything - Add Context Menu Entry
# -------------------------------------------
$everythingRegPath = "D:\Software\PackageManagers\Scoop\apps\everything\current\install-context.reg"
if (Test-Path $everythingRegPath) {
    Write-Host "Importing Everything context menu registry entries..."
    reg import $everythingRegPath
}

# -------------------------------------------
# 2. PowerToys - Add Context Menu Option
# -------------------------------------------
$powertoysScriptPath = "D:\Software\PackageManagers\Scoop\apps\powertoys\current\install-context.ps1"
if (Test-Path $powertoysScriptPath) {
    Write-Host "Adding PowerToys context menu option..."
    Invoke-Expression -Command $powertoysScriptPath
}

# -------------------------------------------
# 3. PowerShell Core (pwsh) - Add Context Menu
# -------------------------------------------
$pwshExplorerReg = "D:\Software\PackageManagers\Scoop\apps\pwsh\current\install-explorer-context.reg"
$pwshFileReg = "D:\Software\PackageManagers\Scoop\apps\pwsh\current\install-file-context.reg"
if (Test-Path $pwshExplorerReg) {
    Write-Host "Adding PowerShell Core (pwsh) to Explorer context menu..."
    reg import $pwshExplorerReg
}
if (Test-Path $pwshFileReg) {
    Write-Host "Adding PowerShell Core (pwsh) to file context menu..."
    reg import $pwshFileReg
}

# -------------------------------------------
# 4. Windows Terminal - Add Context Menu
# -------------------------------------------
$wtRegPath = "D:\Software\PackageManagers\Scoop\apps\windows-terminal\current\install-context.reg"
if (Test-Path $wtRegPath) {
    Write-Host "Importing Windows Terminal context menu registry entries..."
    reg import $wtRegPath
}

# -------------------------------------------
# 5. Python - Register with PEP-514
# -------------------------------------------
$pythonRegPath = "D:\Software\PackageManagers\Scoop\apps\python\current\install-pep-514.reg"
if (Test-Path $pythonRegPath) {
    Write-Host "Importing Python PEP-514 registry entries..."
    reg import $pythonRegPath
}

# -------------------------------------------
# 6. General Recommendations & Warnings
# -------------------------------------------
Write-Host "`nGeneral Recommendations:"
Write-Host "- If you encounter issues with Scoop's aria2c downloader, disable it:"
Write-Host "    scoop config aria2-enabled false"
Write-Host "- Many GUI apps create Start Menu shortcuts. If missing, check the Scoop 'shims' directory."
Write-Host "- Some portable apps (e.g., ImageGlass, paint.net, WizTree) persist config files. Back them up if needed."
Write-Host "- For RTSS (RivaTuner Statistics Server), consider installing 'msiafterburner' and 'vcredist2022' for full functionality."
Write-Host "- Some antivirus programs may flag Scoop shims; whitelist the Scoop directory if necessary."
Write-Host "- Ensure 'D:\Software\PackageManagers\Scoop\shims' is in your PATH. Restart your shell if not recognized."
Write-Host "- After installing new CLI/GUI tools, restart your shell or log out/in for PATH and environment changes to take effect."

# -------------------------------------------
# 7. Per-App Notes
# -------------------------------------------
Write-Host "`nPer-App Specific Notes:"
Write-Host "- ImageGlass: If the app fails, try cleaning 'D:\Software\PackageManagers\Scoop\apps\imageglass\current\igconfig.json'."
Write-Host "- npcap: Installs with a GUI prompt, no silent install switch."
Write-Host "- O&O RegEditor and O&O ShutUp10++: Settings are persisted in .ini files in their Scoop app folders."
Write-Host "- Wireshark: Requires manual install of Npcap and USBPcap from its app directory if needed."
Write-Host "- paint.net, WizTree: Config files are persisted in their app folders for portability."
Write-Host "- oh-my-posh: See https://ohmyposh.dev/docs/installation/prompt for shell-specific configuration."
Write-Host "- For Python, PEP-514 registry entries help third-party installers discover Python."
Write-Host "- PowerShell Core: Profile scripts are persisted in the app directory."

# -------------------------------------------
# 8. Manual Steps (if needed)
# -------------------------------------------
Write-Host "`nManual Steps:"
Write-Host "- After running this script, restart Explorer if you added context menu items:"
Write-Host "    Stop-Process -Name 'explorer'"
Write-Host "- If you have not already, set execution policy to allow running scripts:"
Write-Host "    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"

# -------------------------------------------
# 9. Scoop Usage & Maintenance
# -------------------------------------------
Write-Host "`nScoop Usage Tips:"
Write-Host "- Check for outdated apps: scoop status"
Write-Host "- Update apps: scoop update *"
Write-Host "- Clear old download caches: scoop cache rm *"
Write-Host "- Rollback an app (if an update breaks something): scoop rollback <app>"
Write-Host "- Reset an app to fix issues: scoop reset <app>"
Write-Host "- For system-wide installations, use 'scoop install --global <app>' as administrator."
Write-Host "- You can install directly from a custom manifest file: scoop install path\\to\\manifest.json"

# End of script
