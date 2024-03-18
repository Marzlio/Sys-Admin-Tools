# Retrieve all user profiles
$userProfiles = Get-CimInstance -ClassName Win32_UserProfile

# Define the list of torrent applications
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

# System-level directories to check
$systemDirectories = @(
    "C:\",
    "C:\Temp\",
    "C:\Windows",
    "C:\Program Files",
    "C:\Program Files (x86)",
    "C:\ProgramData",
    "C:\Users\Public",
    "C:\Users\Default",
    "C:\Users\Default User",
    "C:\Users\All Users",
    "C:\Users\DefaultAppPool",
    "C:\Users\LocalService",
    "C:\Users\NetworkService",
    "C:\Windows\System32",
    "C:\Windows\SysWOW64",
    "C:\Windows\Temp",
    "C:\Windows\Installer",
    "C:\Windows\Fonts",
    "C:\Windows\Help",
    "C:\Windows\Inf",
    "C:\Windows\IME",
    "C:\Windows\Logs",
    "C:\Windows\Tasks"
)

foreach ($profile in $userProfiles) {
    # Define the directories to check within each user profile
    $desktopPath = Join-Path -Path $profile.LocalPath -ChildPath "Desktop"
    $downloadsPath = Join-Path -Path $profile.LocalPath -ChildPath "Downloads"
    $documentsPath = Join-Path -Path $profile.LocalPath -ChildPath "Documents"
    $musicPath = Join-Path -Path $profile.LocalPath -ChildPath "My Music"
    $videosPath = Join-Path -Path $profile.LocalPath -ChildPath "My Videos"

    # Combine user-specific directories with system-level directories
    $directories = @($desktopPath, $downloadsPath, $documentsPath, $musicPath, $videosPath) + $systemDirectories

    foreach ($app in $torrentApps) {
        foreach ($dir in $directories) {
            if (Test-Path $dir) {
                $ruleName = "Block_" + $app + "_" + ($dir -replace '\\', '_').Replace(':', '')
                $execName = $app + ".exe"
                $fullPath = Join-Path -Path $dir -ChildPath $execName

                # Check if the rule already exists
                $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
                if ($null -eq $existingRule) {
                    # Create a new rule to block the application
                    New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Program $fullPath -Action Block
                    Write-Host "Created firewall rule to block $app in $dir"
                } else {
                    Write-Host "Firewall rule to block $app in $dir already exists."
                }
            }
        }
    }
}

# Block common torrent ports
$torrentPorts = 6881..6889
foreach ($port in $torrentPorts) {
    $ruleName = "Block_Torrent_Port_$port"
    # Check if the rule already exists
    $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
    if ($null -eq $existingRule) {
        # Create a new rule to block the port
        New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -LocalPort $port -Protocol TCP -Action Block
        New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -LocalPort $port -Protocol UDP -Action Block
        Write-Host "Created firewall rule to block port $port"
    } else {
        Write-Host "Firewall rule to block port $port already exists."
    }
}
