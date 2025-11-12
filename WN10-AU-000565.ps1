 <#
.SYNOPSIS
    Configures Windows 10 to meet STIG WN10-AU-000565 (Audit Other Logon/Logoff Events Failures).

.DESCRIPTION
    This script performs two critical security configurations:
    
    1. It enables the 'Force audit policy subcategory settings' security option
    (WN10-SO-000030) by setting the 'SCENoCategoryFilter' registry value to 1.
    This ensures that advanced audit policies are enforced.
    
    2. It uses the auditpol utility to enable 'Failure' auditing for the
    'Other Logon/Logoff Events' subcategory under the Logon/Logoff category.
    This satisfies the core requirement for WN10-AU-000565.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-12
    Last Modified   : 2025-11-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000565

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000565.ps1 
#>


# Enables the required security option (WN10-SO-000030)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "SCENoCategoryFilter" -Value 1 -Type DWORD -Force

# Configures the advanced audit policy for Failure events
auditpol /set /subcategory:"Other Logon/Logoff Events" /failure:enable


