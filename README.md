# Remove Steam Uninstall Links From Windows

A batch script that removes Steam game entries from the Windows **Settings → Apps** and **Control Panel → Programs and Features** lists.

## What it does

Steam registers each installed game as its own entry in the Windows uninstall registry keys, which causes them to appear in Settings/Control Panel. Since these entries just redirect back to Steam's own uninstaller, this script removes them for a cleaner, decluttered list.

**This script does NOT:**
- Uninstall any games
- Delete any game files
- Remove games from your Steam library

Games remain fully installed and playable through Steam — this only affects visibility in Windows' native app lists.

## Requirements

- Windows 10/11
- Administrator privileges

## Usage

1. Save the script as `RemoveSteamLinks.bat`
2. Right-click the file and select **Run as administrator**
3. Confirm when prompted
4. Press any key to close once complete

## How it works

1. Checks for administrator privileges (exits with an error message if not elevated)
2. Prompts for confirmation before making changes
3. Searches two registry locations for entries containing `"Steam App"`:
   - `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`
   - `HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall`
4. Deletes matching registry keys
5. Reports how many entries were removed

## Notes

- This is a registry-only change — safe to run repeatedly.
- Steam may re-create these entries after future game installs or updates, so you may need to re-run this periodically.
- If you want to restore visibility, simply reinstall or verify the affected game(s) through Steam.

## Disclaimer

This script modifies the Windows registry. While it only targets Steam-specific uninstall entries, always review scripts before running them with administrator privileges.
