#
# Oneliners
#

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-acl
#   Inputs: string, you can pipe string to get-acl
#   Outputs: System.Security.AccessControl.{FileSecurity,DirectorySecurity,RegistrySecurity}
#

# only works in PowerShell command line
# Function:{Write-Info} {Write-Host $args[0] -ForegroundColor DarkMagenta}
function Write-Info([string]$msg) {Write-Host $msg -ForegroundColor DarkMagenta }

Write-Info "Access:"
# Print table that looks like UI "Folder -> Security -> Advanced Security Settings"
Get-Acl -Path "c:\" | Select-Object -ExpandProperty Access | Format-Table
# the same result as above
(Get-Acl -Path "c:\").Access | Format-Table

# filter
Write-Info "-not IsInherited c:\ (filtered:all)"
(Get-Acl -Path "c:\").Access | Where-Object { -not $_.IsInherited } | Format-Table

Write-Info "-not IsInherited c:\Users (filtered:all)"
(Get-Acl -Path "c:\Users").Access | Where-Object { -not $_.IsInherited } | Format-Table

Write-Info "IsInherited c:\Users\ivan.zemskiy (filtered:none)"
(Get-Acl -Path "c:\Users\ivan.zemskiy").Access | Where-Object { $_.IsInherited } | Format-Table

Write-Info "-not IsInherited c:\Users\ivan.zemskiy (filtered:all)"
(Get-Acl -Path "c:\Users\ivan.zemskiy").Access | Where-Object { -not $_.IsInherited } | Format-Table

Get-Acl C:\Windows\s*.log | Format-List -Property PSPath, Sddl
Get-Acl C:\Windows\s*.log -Audit | ForEach-Object { $_.Audit.Count }



# $res = Get-Acl -Path . -Verbose -Debug

# $res.Access
# $res.Access.Count

# $res.Group
# $res.Owner
# $res.Sddl
# $res.Path

