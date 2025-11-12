 <#
.SYNOPSIS
    Checks and configures the maximum size of the System Event Log.

.DESCRIPTION
    Sets the 'MaxSize' registry value for the System event log to 32768 bytes 
    (0x00008000). This ensures the log file has sufficient capacity to retain 
    critical system events for troubleshooting and security analysis.
    It automatically creates the necessary policy key (HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System)
    if it doesn't exist.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-12
    Last Modified   : 2025-11-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000510.ps1 
#>


# Execution: Requires Administrator privileges.

# --- Define the registry settings ---
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$ValueName = "MaxSize"
$RequiredValue = 32768 # 0x00008000 in decimal

# 1. Create the key if it does not exist
if (-not (Test-Path $RegPath)) {
    Write-Host "Registry path '$RegPath' does not exist. Creating it..."
    New-Item -Path $RegPath -Force | Out-Null
}

# 2. Set the registry value
Write-Host "Setting '$ValueName' to $RequiredValue..."
# Use Set-ItemProperty to ensure the value is set, creating or overwriting it
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $RequiredValue -Type DWord -Force

# 3. Verification message
$CurrentValue = Get-ItemPropertyValue -Path $RegPath -Name $ValueName
if ($CurrentValue -eq $RequiredValue) {
    Write-Host "Verification: '$ValueName' is successfully set to $RequiredValue."
}
else {
    Write-Host "Error: Could not verify that '$ValueName' was set to $RequiredValue."
} 
