# Post-Install Suggestions Script

This directory contains a PowerShell script, `post_install_suggestions.ps1`, designed to help you apply recommended registry entries, context menu customizations, and post-install tweaks for software installed via Scoop, based on your installation logs.

## What does the script do?

- **Context Menu Integration:**  
  Adds right-click Explorer menu entries for PowerShell Core, Everything, PowerToys, Windows Terminal, and Python (if installed).
- **App-Specific Reminders:**  
  Includes helpful reminders and warnings for apps like ImageGlass, Wireshark, paint.net, WizTree, oh-my-posh, and others.
- **General Tips:**  
  Summarizes best practices for Scoop usage, maintenance, and troubleshooting.

## How to use

1. **Open PowerShell as Administrator.**
2. **Run the script:**
   ```powershell
   .\post_install_suggestions.ps1
   ```
   The script checks for the presence of context menu registry files before attempting imports.

3. **(Optional) Restart Explorer:**  
   If you added context menu items, you may need to restart Windows Explorer:
   ```powershell
   Stop-Process -Name 'explorer'
   ```

## Manual Steps & Extra Tips

- Some applications (e.g., Wireshark, npcap) may require manual installation or additional configuration. See script comments for details.
- If you encounter issues with Scoop’s downloader, run:
  ```powershell
  scoop config aria2-enabled false
  ```
- Set execution policy if you haven’t already:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

## Troubleshooting

- If context menu items do not appear, ensure you are running PowerShell as administrator.
- For persistent configuration or environment issues, restart your shell or log out/in.
- Refer to the main `MyScoop` README for more advanced usage and troubleshooting.

---

**This script is tailored for your Scoop installation and the software referenced in your installation log. You can customize it further as needed!**
