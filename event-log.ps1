# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog (uses deprecated Win32 API)
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent (Vista+)
[CmdletBinding()]
param()  # support -Debug (see https://learn.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/About/about_commonparameters)

Write-Debug $DebugPreference

[System.Diagnostics.Eventing.Reader.EventLogRecord[]]$events = Get-WinEvent -FilterHashtable @{LogName='Security';Id=4625} -MaxEvents 5000

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
$enc = [System.Text.Encoding]::UTF8
$result = $events | ForEach-Object {
    $lines = $_.Message -split '\n'
    $block = $null
    $r = @{message=$lines[0]}
    foreach ($line in $lines) {
        switch -Regex ($line) {
            "^Subject:" {$block='subject'; Break}
            "^Logon Type:\s+(\d+)" {$block='logon'; $r.type=$Matches[1]; Break}
            "^Account For Which Logon Failed:" {$block='account'; Break}
            "^Failure Information:" {$block='failure'; Break}
            "^Process Information:" {$block='process'; Break}
            "^Network Information:" {$block='network'; Break}
            "^Detailed Authentication Information:" {$block='detailed'; Break}
            default {}
        }
        switch ($block) {
            'account' {
                switch -Regex ($line) {
                    "Security ID:\s+(\S+)" { $r.acl = $Matches[1]; Break }
                    "Account Name:\s+(\S+)" { $r.name = $Matches[1]; Break }
                    "Account Domain:\s+(\S+)" { $r.domain = $Matches[1]; Break }
                    default {}
                }
                Break
            }
            'failure' {
                switch -Regex ($line) {
                    "Failure Reason:\s+([\S ]+)" { $r.reason = $Matches[1]; Break }
                    default {}
                }
                Break
            }
            'process' {
                switch -Regex ($line) {
                    "Caller Process Name:\s+([\S ]+)" { $r.process = $Matches[1]; Break }
                    default {}
                }
                Break
            }
            'network' {
                switch -Regex ($line) {
                    "Workstation Name:\s+([\S ]+)" { $r.pc = $Matches[1]; Break }
                    "Source Network Address:\s+(\S+)" { $r.ip = $Matches[1]; Break }
                    "Source Port:\s+(\d+)" { $r.port = $Matches[1]; Break }
                    default {}
                }
                Break
            }
            'detailed' {
                switch -Regex ($line) {
                    "Logon Process:\s+(\S+)" { $r.logon = $Matches[1]; Break }
                    "Authentication Package:\s+(\S+)" { $r.package = $Matches[1]; Break }
                    default {}
                }
                Break
            }
            default {}
        }
    }
    # return @{$_.Id= "{0}{1} {2}" -f $r.name,$r.domain,$r.acl}
    $str = "({2}) {4}:{5} {6} {7} | {0}{1}" -f $r.name,$r.domain,$r.type,$r.message,$r.ip,$r.port,$r.pc,$r.logon
    #return $enc.GetString($str)
    return $str
}
Write-Host ($result | Out-String)
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
