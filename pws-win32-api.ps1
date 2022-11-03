
# https://jrich523.wordpress.com/2012/04/27/powershell-remove-a-drive-mountletter-more-win32/
# from https://social.technet.microsoft.com/wiki/contents/articles/7804.powershell-creating-custom-objects.aspx

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class MountPoint
{
[DllImport("kernel32.dll", CharSet=CharSet.Auto, SetLastError=true)]
public static extern bool DeleteVolumeMountPoint(string mountPoint);
}
"@

[MountPoint]::DeleteVolumeMountPoint("G:\")
