cls

:: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754622(v=ws.11)

@REM NET /?
:: The syntax of this command is:
:: NET
::     [ ACCOUNTS | COMPUTER | CONFIG | CONTINUE | FILE | GROUP | HELP |
::       HELPMSG | LOCALGROUP | PAUSE | SESSION | SHARE | START |
::       STATISTICS | STOP | TIME | USE | USER | VIEW ]

NET HELP
:: command
::      -or-
:: NET command /HELP
::   Commands available are:
::   NET ACCOUNTS             NET HELPMSG              NET STATISTICS
::   NET COMPUTER             NET LOCALGROUP           NET STOP
::   NET CONFIG               NET PAUSE                NET TIME
::   NET CONTINUE             NET SESSION              NET USE
::   NET FILE                 NET SHARE                NET USER
::   NET GROUP                NET START                NET VIEW
::   NET HELP
::   NET HELP NAMES explains different types of names in NET HELP syntax lines.
::   NET HELP SERVICES lists some of the services you can start.
::   NET HELP SYNTAX explains how to read NET HELP syntax lines.
::   NET HELP command | MORE displays Help one screen at a time.

NET LOCALGROUP
:: Aliases for \\ZS120019
:: -------------------------------------------------------------------------------
:: *Access Control Assistance Operators
:: *Administrators
:: *Backup Operators
:: *ConfigMgr Remote Control Users
:: *Cryptographic Operators
:: *Device Owners
:: *Distributed COM Users
:: *Event Log Readers
:: *Guests
:: *Hyper-V Administrators
:: *IIS_IUSRS
:: *Network Configuration Operators
:: *Performance Log Users
:: *Performance Monitor Users
:: *Power Users
:: *Remote Desktop Users
:: *Remote Management Users
:: *Replicator
:: *System Managed Accounts Group
:: *Users
:: The command completed successfully.

@REM NET GROUP
:: This command can be used only on a Windows Domain Controller.
:: More help is available by typing NET HELPMSG 3515.

NET USER
:: User accounts for \\
:: -------------------------------------------------------------------------------
:: Administrator            DefaultAccount           localadmin
:: LocalGuest               WDAGUtilityAccount
:: The command completed with one or more errors.

NET STATISTICS
NET STATISTICS Workstation

NET LOCALGROUP Administrators
:: Alias name     Administrators
:: Comment        Administrators have complete and unrestricted access to the computer/domain
:: Members
:: -------------------------------------------------------------------------------
:: Administrator
:: localadmin
:: MERA\Domain Admins
:: MERA\ivan.zemskiy
:: The command completed successfully.
NET USER Administrator

@REM NET USER MERA\ivan.zemskiy
@REM NET HELP USER
:: NET USER
:: [username [password | *] [options]] [/DOMAIN]
::          username {password | *} /ADD [options] [/DOMAIN]
::          username [/DELETE] [/DOMAIN]
::          username [/TIMES:{times | ALL}]
::          username [/ACTIVE: {YES | NO}]
:: NET USER creates and modifies user accounts on computers. When used
:: without switches, it lists the user accounts for the computer. The
:: user account information is stored in the user accounts database.
:: username     Is the name of the user account to add, delete, modify, or
::              view. The name of the user account can have as many as
::              20 characters.
:: password     Assigns or changes a password for the user's account.
::              A password must satisfy the minimum length set with the
::              /MINPWLEN option of the NET ACCOUNTS command. It can have as
::              many as 14 characters.
:: *            Produces a prompt for the password. The password is not
::              displayed when you type it at a password prompt.
:: /DOMAIN      Performs the operation on a domain controller of
::              the current domain.
:: /ADD         Adds a user account to the user accounts database.
:: /DELETE      Removes a user account from the user accounts database.
:: Options      Are as follows:
::    Options                    Description
::       --------------------------------------------------------------------
::    /ACTIVE:{YES | NO}         Activates or deactivates the account. If
::                               the account is not active, the user cannot
::                               access the server. The default is YES.
::    /COMMENT:"text"            Provides a descriptive comment about the
::                               user's account.  Enclose the text in
::                               quotation marks.
::    /COUNTRYCODE:nnn           Uses the operating system country/region code
::                               to implement the specified language files for
::                               a user's help and error messages. A value of
::                               0 signifies the default country/region code.
::    /EXPIRES:{date | NEVER}    Causes the account to expire if date is
::                               set. NEVER sets no time limit on the
::                               account. An expiration date is in the
::                               form mm/dd/yy(yy). Months can be a number,
::                               spelled out, or abbreviated with three
::                               letters. Year can be two or four numbers.
::                               Use slashes(/) (no spaces) to separate
::                               parts of the date.
::    /FULLNAME:"name"           Is a user's full name (rather than a
::                               username). Enclose the name in quotation
::                               marks.
::    /HOMEDIR:pathname          Sets the path for the user's home directory.
::                               The path must exist.
::    /PASSWORDCHG:{YES | NO}    Specifies whether users can change their
::                               own password. The default is YES.
::    /PASSWORDREQ:{YES | NO}    Specifies whether a user account must have
::                               a password. The default is YES.
::    /LOGONPASSWORDCHG:{YES|NO} Specifies whether user should change their
::                               own password at the next logon.The default is NO.
::    /PROFILEPATH[:path]        Sets a path for the user's logon profile.
::    /SCRIPTPATH:pathname       Is the location of the user's logon
::                               script.
::    /TIMES:{times | ALL}       Is the logon hours. TIMES is expressed as
::                               day[-day][,day[-day]],time[-time][,time
::                               [-time]], limited to 1-hour increments.
::                               Days can be spelled out or abbreviated.
::                               Hours can be 12- or 24-hour notation. For
::                               12-hour notation, use am, pm, a.m., or
::                               p.m. ALL means a user can always log on,
::                               and a blank value means a user can never
::                               log on. Separate day and time entries with
::                               a comma, and separate multiple day and time
::                               entries with a semicolon.
::    /USERCOMMENT:"text"        Lets an administrator add or change the User
::                               Comment for the account.
::    /WORKSTATIONS:{computername[,...] | *}
::                               Lists as many as eight computers from
::                               which a user can log on to the network. If
::                               /WORKSTATIONS has no list or if the list is *,
::                               the user can log on from any computer.

@REM NET USER ivan.zemskiy /DOMAIN
:: Access denied


