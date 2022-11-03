# Error: Attempted to perform an unauthorized operation.
$all = Get-WinEvent -ListLog * -ErrorAction SilentlyContinue

# Use F8 in VSCode to run line-by-line
$top20 = $all | Group-Object RecordCount | Sort-Object Count -Descending -Top 20
$top20
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member
$top20 | Select-Object -ExpandProperty Group | Get-Member -MemberType Property
$top20 | Select-Object -ExpandProperty Group | Get-Member -View Extended -Force
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pscustomobject
($top20 | Select-Object -ExpandProperty Group).pstypenames  # System.Object[] System.Array System.Object
($top20 | Select-Object -ExpandProperty Group).GetType()  # Object[] (BaseType System.Array)
($top20 | Select-Object -ExpandProperty Group).GetType().GetInterfaces()  # IList, IList`1 - 'arity' indicator
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_properties?view=powershell-7.2#member-access-enumeration
$top20.Group
$top20 | Select-Object -ExpandProperty Group
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_calculated_properties
# Select-Object: @{name/label - optional; expression} @{n/l;e}
$top20
$top20 | Select-Object @{n='LogName';e={$_.Group.LogName}}
$top20 | Select-Object Count, Name, @{n='LogName';e={$_.Group.LogName}}
$top20 | Select-Object Count, Name, @{n='LogName';e={$_.Group.LogName -join ', '}}

$all
$all | Group-Object RecordCount | Sort-Object RecordCount -Descending -Bottom 20 | Select-Object -Property @{n='RecordCount';e='Name'}, Count, @{n='LogName';e={$_.Group.LogName}} | Format-Table

# merabook
# 2 try    1 try
#          RecordCount Count LogName
#          ----------- ----- -------
#                          ...
# 5912  <- 5912            1 Cisco AnyConnect Secure Mobility Client
# 17454 <- 17454           1 Microsoft-Windows-TaskScheduler/Operational
# 22866 <- 22803           1 Application
# 26373 <- 26513           1 Microsoft-Windows-Store/Operational
# 27498 <- 27436           1 System
# 92867 <- 92962           1 Security
#
# new value is less than previous one (max log size exceded?)
