[CmdletBinding()]Param()
# Param()
# .\pws-openssh.ps1: A parameter with the name 'Debug' was defined multiple times for the command.
# https://stackoverflow.com/questions/65700615/powershell-a-parameter-with-the-name-was-defined-multiple-times-for-the-command
# Param([Parameter(Position=0, Mandatory=$False, ValueFromPipeline=$False, ParameterSetName="Debug")] [switch]$Debug)

Clear-Host

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service
$serv = Get-Service sshd
$serv | Format-List

# https://learn.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/About/about_Preference_Variables
# $DebugPreference = 'Continue'

# https://learn.microsoft.com/en-us/dotnet/api/system.serviceprocess.servicecontroller
Write-Debug "$serv"

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service#notes
# Beginning in PowerShell 6.0, the following properties are added to the ServiceController objects:
# UserName, Description, DelayedAutoStart, BinaryPathName, and StartupType.
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators#format-operator--f
# https://learn.microsoft.com/en-us/dotnet/api/system.string.format#control-alignment
# https://learn.microsoft.com/en-us/dotnet/standard/base-types/composite-formatting
Write-Debug ("{0,-18} -> {1,10} : {2}" -f "`$serv.StartType", $serv.StartType, $serv.StartType.GetType())
Write-Debug ("{0,-18} -> {1,10} : {2}" -f "`$serv.StartupType", $serv.StartupType, $serv.StartupType.GetType())

# $serv.StartType.GetType() | Format-List -Property *Name*
# $serv.StartupType.GetType() | Format-List -Property *Name*

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables
Write-Debug ([ordered]@{
    'StartType   -eq "Automatic"'                     = $serv.StartType -eq "Automatic";
    'StartType   -eq [ServiceStartMode]::Automatic'   = $serv.StartType -eq [System.ServiceProcess.ServiceStartMode]::Automatic;
    'StartupType -eq "Automatic"'                     = $serv.StartupType -eq "Automatic";
    'StartupType -eq [ServiceStartupType]::Automatic' = $serv.StartupType -eq [Microsoft.PowerShell.Commands.ServiceStartupType]::Automatic;
} | Format-Table -AutoSize | Out-String)
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-expression
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays
# @(
#     '$serv.StartType -eq "Automatic"';
#     '$serv.StartType -eq [System.ServiceProcess.ServiceStartMode]::Automatic';
#     '$serv.StartupType -eq "Automatic"';
#     '$serv.StartupType -eq [Microsoft.PowerShell.Commands.ServiceStartupType]::Automatic';
# ) | ForEach-Object -Process {Invoke-Expression $_}

# ServiceStartMode vs ServiceStartupType
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service#outputs
# https://learn.microsoft.com/en-us/dotnet/api/system.serviceprocess.servicecontroller.starttype#system-serviceprocess-servicecontroller-starttype
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-service#-startuptype
# Automatic, AutomaticDelayedStart, Disabled, InvalidValue, Manual

if ($serv.StartupType -ne [Microsoft.PowerShell.Commands.ServiceStartupType]::Automatic) {
    Write-Host "make service `sshd' autorunnable on boot"
    Set-Service sshd -StartupType Automatic
}

if (!$serv.CanStop) {
    Write-Host "start service `sshd'"
    Start-Service sshd
}

if ($serv.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running -and
    $serv.StartupType -eq [Microsoft.PowerShell.Commands.ServiceStartupType]::Automatic) {
    Write-Host "Service is Running and Autostarts after Boot"
}

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-debug
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters
# Write-Debug "eof"
