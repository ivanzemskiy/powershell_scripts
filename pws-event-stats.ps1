# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog (uses deprecated Win32 API)
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent (Vista+)
[CmdletBinding()]
param()  # support -Debug (see https://learn.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/About/about_commonparameters)

Write-Debug $DebugPreference

# configuaration
[System.Diagnostics.Eventing.Reader.EventLogConfiguration[]]$config = Get-WinEvent -ListLog 'Security'
Write-Debug ($config | Get-Member | Out-String)
$config | Format-List -Property *

Write-Debug (Get-WinEvent -FilterHashtable @{LogName='Security'} -MaxEvents 10 | Out-String)
Write-Debug (Get-WinEvent -FilterHashtable @{LogName='Security'} -MaxEvents 10 | Get-Member | Format-Table | Out-String)
Write-Debug (Get-WinEvent -FilterHashtable @{LogName='Security'} -MaxEvents 10 | Format-List -Property * | Out-String)

# stats
[System.Diagnostics.Eventing.Reader.EventLogRecord[]]$events = Get-WinEvent -LogName Security
# $events[0] | Format-List -Property *
$events | Group-Object -Property Id -NoElement | Sort-Object -Property Count -Descending | Format-Table Count, @{Label='Id'; Expression='Name'}
$events | Group-Object -Property LevelDisplayName -NoElement | Format-Table Count, @{Label='LevelDisplayName'; Expression='Name'}
Write-Host ("{0} from {1}" -f $events.Count, $config.RecordCount)
