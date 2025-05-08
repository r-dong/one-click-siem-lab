# setup.ps1
# Purpose: Automates honeypot VM: disables firewall, installs Sysmon with config

Function Write-Status {
    param ([string]$msg)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Output "$timestamp - $msg"
}

Write-Status "==== Setup script (setup.ps1) started ===="

# Disable Windows Firewall
try {
    Write-Status "Disabling Windows Firewall..."
    Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
    Write-Status "Windows Firewall disabled successfully."
}
catch {
    Write-Status "ERROR: Could not disable firewall - $_"
}

# Create working folder
$tempPath = "C:\Tools"
try {
    Write-Status "Creating working directory at $tempPath..."
    New-Item -Path $tempPath -ItemType Directory -Force | Out-Null
    Write-Status "Directory created."
}
catch {
    Write-Status "ERROR: Failed to create directory - $_"
}

# Download Sysmon
try {
    $sysmonZip = "$tempPath\Sysmon.zip"
    Write-Status "Downloading Sysmon..."
    Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Sysmon.zip" -OutFile $sysmonZip
    Write-Status "Sysmon downloaded to $sysmonZip"
}
catch {
    Write-Status "ERROR: Sysmon download failed - $_"
}

# Extract Sysmon
try {
    Write-Status "Extracting Sysmon..."
    Expand-Archive -Path $sysmonZip -DestinationPath $tempPath -Force
    Write-Status "Sysmon extracted."
}
catch {
    Write-Status "ERROR: Failed to extract Sysmon - $_"
}

# Download Sysmon config
try {
    $configPath = "$tempPath\sysmonconfig.xml"
    Write-Status "Downloading Sysmon configuration..."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile $configPath
    Write-Status "Config downloaded to $configPath"
}
catch {
    Write-Status "ERROR: Config download failed - $_"
}

# Install Sysmon
try {
    $sysmonExe = "$tempPath\Sysmon64.exe"
    Write-Status "Installing Sysmon with config..."
    Start-Process -FilePath $sysmonExe -ArgumentList "-accepteula -i $configPath" -Wait
    Write-Status "Sysmon installed successfully."
}
catch {
    Write-Status "ERROR: Failed to install Sysmon - $_"
}

Write-Status "==== Setup script completed ===="