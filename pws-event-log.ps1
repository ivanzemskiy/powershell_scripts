# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog (uses deprecated Win32 API)
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent (Vista+)
[CmdletBinding()]
param()  # support -Debug (see https://learn.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/About/about_commonparameters)

Write-Debug $DebugPreference

[System.Diagnostics.Eventing.Reader.EventLogRecord[]]$events = Get-WinEvent -FilterHashtable @{LogName='Security';Id=4719} -MaxEvents 5

# https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4625
# https://learn.microsoft.com/en-us/answers/questions/198575/event-log-failure-4625-brute-force-attack.html
# I am receiving constant 4625 event log failures in my machine every 10 minutes. The machine lies under the firewall with RDP enabled in it.
# >>> a workaround I would suggest to perform NTLM policy control to completely prevent LM response
# Local Security Policy-->Local Policy-->Security Options-->Network security: LAN Manager authentication level-->set to Send NTLMv2 response only
# Local Security Policy-->Local Policy-->Security Options-->Network security: Restrict NTLM: Incoming NTLM traffic-->set to Deny all accounts

# Write-Host "`nMessage:" -ForegroundColor DarkMagenta
# $events[0].Message
# Write-Host "Grep:" -ForegroundColor DarkMagenta
# $events[0].Message -split '\n' | Select-String -Pattern '^\S' | Out-String
# Write-Host "Grep2:" -ForegroundColor DarkMagenta
# $events[0].Message -split '\n' | Select-String -Pattern '^\s' | Out-String

# Get-WinEvent -LogName Security -MaxEvents 5 | Format-List -Property Message
# Get-WinEvent -LogName Security -MaxEvents 5 | Format-List -Property Message | OSS | Select-String -Pattern "Subject:"

# $events.Message | OSS | Select-String -Pattern "^."
# $events | Format-List -Property Message | OSS | Select-String -Pattern "^."
# $events.Message % { $_ -split '\n' } | Select-String -Pattern "^."  # [System.Object[]] does not contain a method named 'op_Modulus'

# $events | ForEach-Object { $_.Message -split '\n' } | Select-String -Pattern "^\s+(?:Category):"

# $indent = "        "
$result = $events | ForEach-Object {
    $lines = $_.Message -split '\n'
    $block = $null
    $obj = @{message=$lines[0]}
    foreach ($line in $lines) {
        switch -Regex ($line) {
            "^(Subject):" {$block=$Matches[1]; Break}
            "^(Audit Policy Change):" {$block=$Matches[1]; Break}
            default {}
        }
        switch ($block) {
            'Subject' {
                switch -Regex ($line) {
                    "Security ID:\s+(\S+)" { $obj.secid = $Matches[1]; Break }
                    "Account Name:\s+(\S+)" { $obj.account = $Matches[1]; Break }
                    "Account Domain:\s+(\S+)" { $obj.domain = $Matches[1]; Break }
                    "Logon ID:\s+(\S+)" { $obj.logonid = $Matches[1]; Break }
                    default {}
                }
                Break
            }
            'Audit Policy Change' {
                switch -Regex ($line) {
                    "Category:\s+([\S ]+)" { $obj.category = $Matches[1]; Break }
                    "Subcategory:\s+([\S ]+)" { $obj.category = $Matches[1]; Break }
                    "Changes:\s+([\S ]+)" { $obj.changes = $Matches[1] -split ', '; Break }
                    default {}
                }
                Break
            }
            default {}
        }
    }
    return [PSCustomObject]$obj
}
$result | Format-Table

# Get-Member -InputObject $result

# Write-Host ($result | Out-String)
# Write-Host ($result[0] | Out-String)

#  | Select-String -Pattern "^\s+(?:Category):"

# Message      : An account failed to log on.
#
#                Subject:
#                 Security ID:            S-1-0-0
#                 Account Name:           -
#                 Account Domain:         -
#                 Logon ID:               0x0
#
#                Logon Type:                      3
#
#                Account For Which Logon Failed:
#                 Security ID:            S-1-0-0
#                 Account Name:           administrator
#                 Account Domain:
#
#                Failure Information:
#                 Failure Reason:         Unknown user name or bad password.
#                 Status:                 0xC000006D
#                 Sub Status:             0xC000006A
#
#                Process Information:
#                 Caller Process ID:      0x0
#                 Caller Process Name:    -
#
#                Network Information:
#                 Workstation Name:       -
#                 Source Network Address: 95.87.254.90
#                 Source Port:            56835
#
#                Detailed Authentication Information:
#                 Logon Process:          NtLmSsp
#                 Authentication Package: NTLM
#                 Transited Services:     -
#                 Package Name (NTLM only):       -
#                 Key Length:             0
#
#                This event is generated when a logon request fails. It is generated on the computer where access was attempted.
#
#                The Subject fields indicate the account on the local system which requested the logon. This is most commonly a service such as the S
#                erver service, or a local process such as Winlogon.exe or Services.exe.
#
#                The Logon Type field indicates the kind of logon that was requested. The most common types are 2 (interactive) and 3 (network).
#
#                The Process Information fields indicate which account and process on the system requested the logon.
#
#                The Network Information fields indicate where a remote logon request originated. Workstation name is not always available and may be
#                 left blank in some cases.
#
#                The authentication information fields provide detailed information about this specific logon request.
#                 - Transited services indicate which intermediate services have participated in this logon request.
#                 - Package name indicates which sub-protocol was used among the NTLM protocols.
#                 - Key length indicates the length of the generated session key. This will be 0 if no session key was requested.
