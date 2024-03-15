# This script creates Windows Firewall rules to block common BitTorrent applications and ports.
# The script creates rules to block the following BitTorrent applications:
$torrentApps = @(
    "uTorrent",
    "BitTorrent",
    "qBittorrent",
    "Vuze",
    "Deluge",
    "Transmission",
    "Tixati",
    "BitComet",
    "FrostWire",
    "Tribler",
    "BitLord",
    "BitSpirit",
    "Halite",
    "KTorrent",
    "PicoTorrent",
    "WebTorrent"
)
# The script creates rules to block the following common paths:
$commonPaths = @(
    [Environment]::GetFolderPath("Desktop"),
    [Environment]::GetFolderPath("Downloads"),
    [Environment]::GetFolderPath("MyDocuments"),
    [Environment]::GetFolderPath("ProgramFiles"),
    [Environment]::GetFolderPath("ProgramFilesX86"),
    [Environment]::GetFolderPath("ProgramFilesCommon"),
    [Environment]::GetFolderPath("ProgramFilesX86Common"),
    [Environment]::GetFolderPath("UserProfile"),
    [Environment]::GetFolderPath("Windows"),
    "C:\",
    "C:\ProgramData",
    "C:\Users\*\AppData\Roaming",
    "C:\Users\*\AppData\Local"
)

# Create firewall rules to block the BitTorrent applications
foreach ($app in $torrentApps) {
    # Create a regular expression pattern to match app names with variations
    $pattern = re.compile(r"^(.*?)" + $app + r"\b", re.IGNORECASE)  

    foreach ($path in $commonPaths) {
        $ruleName = "Block" + $app + "_" + $path.Replace(":", "").Replace("\", "")

        # Enumerate potential executable names based on the pattern
        $potentialExes = Get-ChildItem -Path $path -Filter "*$($app)*.exe" -ErrorAction SilentlyContinue 

        foreach ($exe in $potentialExes) {
            $fullPath = $exe.FullName

            if ($pattern.match($exe.Name)) {
                # Check if the rule already exists
                $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
                if ($null -eq $existingRule) {
                    # Create a new rule to block the application
                    New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Program $fullPath -Action Block
                    Write-Host "Created firewall rule to block $exe.Name in $path"
                } else {
                    Write-Host "Firewall rule to block $exe.Name in $path already exists."
                }
            }
        }
    }
}

# Blocking common BitTorrent ports
$commonPorts = 6881..6889
foreach ($port in $commonPorts) {
    $ruleName = "Block_BitTorrent_Port_$port"
    $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
    if ($null -eq $existingRule) {
        New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Protocol TCP -LocalPort $port -Action Block
        New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Protocol UDP -LocalPort $port -Action Block
        Write-Host "Created firewall rule to block TCP and UDP port $port"
    } else {
        Write-Host "Firewall rule to block TCP and UDP port $port already exists."
    }
}