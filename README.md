# Sys-Admin-Tools

A collection of PowerShell scripts and executable files to simplify common system administration tasks, focusing on network traffic control.

## Current Scripts and Executables

* **Basic_Social_Media_Blocking.ps1 / Basic_Social_Media_Blocking.exe**
   - Blocks access to popular social media websites by modifying the Windows hosts file. 
   - **Customizable:** Easily add or remove websites from the `$blockedSites` array.
   - The `.exe` file is a compiled version of the script for easier execution.

* **Basic_Torrent_Blocking.ps1 / Basic_Torrent_Blocking.exe**
   - Blocks common torrenting applications by creating Windows Firewall rules.
   - Blocks outgoing traffic on typical BitTorrent ports. 
   - **Customizable:**  
      - Expand the `$torrentApps` array to target more torrent clients.  
      - Modify the `$commonPorts` array to block different port ranges.
   - The `.exe` file is a compiled version of the script for easier execution.

## Usage

1. **Prerequisites:**
    - Windows PowerShell (version 5.1 or later recommended) or Windows environment for EXE.
    - Administrator privileges.
2. **Download:** Clone this repository or download the individual scripts or executables.
3. **Execution:** 
    - For PowerShell scripts, navigate to the directory containing the script and run it in PowerShell: `.\Basic_Social_Media_Blocking.ps1` or `.\Basic_Torrent_Blocking.ps1`.
    - For executables, simply double-click the file or run it from the command line.

**Important Notes**

* These tools provide basic blocking mechanisms. More sophisticated techniques may be required for advanced circumvention.
* Always review the scripts and executable content carefully and test in a non-production environment before wide deployment.

## Customization

Feel free to modify the scripts to fit your specific needs. Areas for customization include:
* **Targeting different websites or applications.**
* **Adjusting firewall port blocking ranges.**

## Contributing

Contributions are welcome! If you have improvements, new scripts, executables, or ideas:

1. Fork the repository.
2. Create your feature branch.
3. Commit your changes.
4. Submit a pull request.

## Disclaimer

These scripts and executables are provided for informational and educational purposes. Use at your own risk, and ensure compliance with any applicable policies or regulations.
