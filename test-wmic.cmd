cls

@REM help
:: WMIC           Displays WMI information inside interactive command shell.

@REM WMIC /?
:: WMIC is deprecated.
::
:: [global switches] <command>
::
:: The following global switches are available:
:: /NAMESPACE           Path for the namespace the alias operate against.
:: /ROLE                Path for the role containing the alias definitions.
:: /NODE                Servers the alias will operate against.
:: /IMPLEVEL            Client impersonation level.
:: /AUTHLEVEL           Client authentication level.
:: /LOCALE              Language id the client should use.
:: /PRIVILEGES          Enable or disable all privileges.
:: /TRACE               Outputs debugging information to stderr.
:: /RECORD              Logs all input commands and output.
:: /INTERACTIVE         Sets or resets the interactive mode.
:: /FAILFAST            Sets or resets the FailFast mode.
:: /USER                User to be used during the session.
:: /PASSWORD            Password to be used for session login.
:: /OUTPUT              Specifies the mode for output redirection.
:: /APPEND              Specifies the mode for output redirection.
:: /AGGREGATE           Sets or resets aggregate mode.
:: /AUTHORITY           Specifies the <authority type> for the connection.
:: /?[:<BRIEF|FULL>]    Usage information.
::
:: For more information on a specific global switch, type: switch-name /?
::
::
:: The following alias/es are available in the current role:
:: ALIAS                    - Access to the aliases available on the local system
:: BASEBOARD                - Base board (also known as a motherboard or system board) management.
:: BIOS                     - Basic input/output services (BIOS) management.
:: BOOTCONFIG               - Boot configuration management.
:: CDROM                    - CD-ROM management.
:: COMPUTERSYSTEM           - Computer system management.
:: CPU                      - CPU management.
:: CSPRODUCT                - Computer system product information from SMBIOS.
:: DATAFILE                 - DataFile Management.
:: DCOMAPP                  - DCOM Application management.top
:: DESKTOP                  - User's Desktop management.
:: DESKTOPMONITOR           - Desktop Monitor management.
:: DEVICEMEMORYADDRESS      - Device memory addresses management.
:: DISKDRIVE                - Physical disk drive management.
:: DISKQUOTA                - Disk space usage for NTFS volumes.
:: DMACHANNEL               - Direct memory access (DMA) channel management.
:: ENVIRONMENT              - System environment settings management.
:: FSDIR                    - Filesystem directory entry management.
:: GROUP                    - Group account management.
:: IDECONTROLLER            - IDE Controller management.
:: IRQ                      - Interrupt request line (IRQ) management.
:: JOB                      - Provides  access to the jobs scheduled using the schedule service.
:: LOADORDER                - Management of system services that define execution dependencies.
:: LOGICALDISK              - Local storage device management.
:: LOGON                    - LOGON Sessions.
:: MEMCACHE                 - Cache memory management.
:: MEMORYCHIP               - Memory chip information.
:: MEMPHYSICAL              - Computer system's physical memory management.
:: NETCLIENT                - Network Client management. stop
:: NETLOGIN                 - Network login information (of a particular user) management.
:: NETPROTOCOL              - Protocols (and their network characteristics) management.
:: NETUSE                   - Active network connection management.
:: NIC                      - Network Interface Controller (NIC) management.
:: NICCONFIG                - Network adapter management.
:: NTDOMAIN                 - NT Domain management.
:: NTEVENT                  - Entries in the NT Event Log.
:: NTEVENTLOG               - NT eventlog file management.
:: ONBOARDDEVICE            - Management of common adapter devices built into the motherboard (system board).
:: OS                       - Installed Operating System/s management.
:: PAGEFILE                 - Virtual memory file swapping management.
:: PAGEFILESET              - Page file settings management.
:: PARTITION                - Management of partitioned areas of a physical disk.
:: PORT                     - I/O port management.
:: PORTCONNECTOR            - Physical connection ports management.
:: PRINTER                  - Printer device management.
:: PRINTERCONFIG            - Printer device configuration management.
:: PRINTJOB                 - Print job management.
:: PROCESS                  - Process management. key to stop
:: PRODUCT                  - Installation package task management.
:: QFE                      - Quick Fix Engineering.
:: QUOTASETTING             - Setting information for disk quotas on a volume.
:: RDACCOUNT                - Remote Desktop connection permission management.
:: RDNIC                    - Remote Desktop connection management on a specific network adapter.
:: RDPERMISSIONS            - Permissions to a specific Remote Desktop connection.
:: RDTOGGLE                 - Turning Remote Desktop listener on or off remotely.
:: RECOVEROS                - Information that will be gathered from memory when the operating system fails.
:: REGISTRY                 - Computer system registry management.
:: SCSICONTROLLER           - SCSI Controller management.
:: SERVER                   - Server information management.
:: SERVICE                  - Service application management.
:: SHADOWCOPY               - Shadow copy management.
:: SHADOWSTORAGE            - Shadow copy storage area management.
:: SHARE                    - Shared resource management.
:: SOFTWAREELEMENT          - Management of the  elements of a software product installed on a system.
:: SOFTWAREFEATURE          - Management of software product subsets of SoftwareElement.
:: SOUNDDEV                 - Sound Device management.
:: STARTUP                  - Management of commands that run automatically when users log onto the computer system.
:: SYSACCOUNT               - System account management.
:: SYSDRIVER                - Management of the system driver for a base service.
:: SYSTEMENCLOSURE          - Physical system enclosure management.
:: SYSTEMSLOT               - Management of physical connection points including ports,  slots and peripherals, and proprietary connections points.
:: TAPEDRIVE                - Tape drive management.
:: TEMPERATURE              - Data management of a temperature sensor (electronic thermometer).
:: TIMEZONE                 - Time zone data management.
:: UPS                      - Uninterruptible power supply (UPS) management.
:: USERACCOUNT              - User account management.
:: VOLTAGE                  - Voltage sensor (electronic voltmeter) data management.
:: VOLUME                   - Local storage volume management.
:: VOLUMEQUOTASETTING       - Associates the disk quota setting with a specific disk volume.
:: VOLUMEUSERQUOTA          - Per user storage volume quota management.
:: WMISET                   - WMI service operational parameters management.
::
:: For more information on a specific alias, type: alias /?
::
:: CLASS     - Escapes to full WMI schema.
:: PATH      - Escapes to full WMI object paths.E key to stop
:: CONTEXT   - Displays the state of all the global switches.
:: QUIT/EXIT - Exits the program.
::
:: For more information on CLASS/PATH/CONTEXT, type: (CLASS | PATH | CONTEXT) /?

