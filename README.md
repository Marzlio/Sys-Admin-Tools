# Sys-Admin-Tools

A collection of PowerShell scripts to simplify common system administration tasks, focusing on network traffic control.

## Current Scripts

* **Basic_Social_Media_Blocking.ps1** 
   - Blocks access to popular social media websites by modifying the Windows hosts file. 
   - **Customizable:** Easily add or remove websites from the `$blockedSites` array.
* **Basic_Torrent_Blocking.ps1**
   - Blocks common torrenting applications by creating Windows Firewall rules.
   - Blocks outgoing traffic on typical BitTorrent ports. 
   - **Customizable:**  
      - Expand the `$torrentApps` array to target more torrent clients.  
      - Modify the `$commonPorts` array to block different port ranges.

## Usage

1. **Prerequisites:**
    - Windows PowerShell (version 5.1 or later recommended)
    - Administrator privileges
2. **Download:** Clone this repository or download the individual scripts.
3. **Execution:** 
    - Navigate to the directory containing the script.
    - Run the script in PowerShell:  `.\Basic_Social_Media_Blocking.ps1`or `.\Basic_Torrent_Blocking.ps1` 

**Important Notes**

* These scripts provide basic blocking mechanisms. More sophisticated techniques may be required for advanced circumvention.
* Always review the scripts carefully and test in a non-production environment before wide deployment.

## Customization

Feel free to modify the scripts to fit your specific needs. Areas for customization include:
* **Targeting different websites or applications**
* **Adjusting firewall port blocking ranges**

## Contributing

Contributions are welcome! If you have improvements, new scripts, or ideas:

1. Fork the repository.
2. Create your feature branch.
3. Commit your changes.
4. Submit a pull request.

## Disclaimer
These scripts are provided for informational and educational purposes. Use at your own risk, and ensure compliance with any applicable policies or regulations.
