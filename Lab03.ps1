<# LAB03 #>

<# Exercise 1 #>

<# Using a keyword such as date, find a command that can display the current date. #>
Get-Command *date*
# ANSWER
Get-Date

<# Display the members of the object produced by the command that you found in the previous step. #>
# ANSWER
Get-Date | Get-Member

<# Display only the day of the year. #>
get-help get-date -Online
# ANSWER
Get-Date | Select-Object -Property DayOfYear

<# Display the results of the previous command with the name of the property and its value on a single line. #>
Get-Date | Select-Object -expandProperty DayOfYear
# ANSWER
Get-Date | Select-Object -Property DayOfYear | Format-List

<# TASK 02 #>
<# Using a keyword such as hotfix, find a command that can display a list of the installed hotfixes. #>
Get-Command *hotfix*
get-help get-hotfix -Online
# ANSWER
Get-HotFix

<# Display the members of the object produced by the command that you found in the previous step. #>
# ANSWER
Get-HotFix | Get-Member

<# Display a list of the installed hotfixes. Display only the installation date, hotfix ID number, and name of the user who installed the hotfix. #>
Get-HotFix | Select-Object -Property *
# ANSWER
Get-HotFix | Select-Object -Property InstalledOn, HotFixID, InstalledBy

<# Display a list of the installed hotfixes. Display only the hotfix ID, the number of days since the hotfix was installed, and the name of the user who installed the hotfix #>
Get-HotFix | Select-Object -Property *
Get-HotFix | Select-Object -Property InstalledOn, HotFixID, InstalledBy
# ANSWER
Get-HotFix | Select-Object -Property HotFixID,@{n='DaysSinceHotFix';e={((Get-Date) - $_.InstalledOn).Days}}, InstalledBy

<# TASK 3 #>
<# Using a keyword such as DHCP or scope, find a command that can display a list of Internet Protocol version 4 (IPv4) Dynamic Host Configuration Protocol (DHCP) scopes. #>
get-command -noun *DHCP*
get-dhcpserverv4Scope # Fails to get version because we are on CL1 and the DHCP Server is on DC1
# ANSWER
Get-DHCPServerV4Scope -ComputerName LON-DC1

<# Display a list of the available IPv4 DHCP scopes on LON-DC1. This time, include only the scope ID, subnet mask, and scope name, and display the output Property:Data results in a single column down the screen. #>
# ANSWER
Get-DHCPServerV4Scope -ComputerName Lon-DC1 | Select-Object ScopeID, SubnetMask, Name | Format-List

<# Task 4 #>
<# Using a keyword such as rule, find a command that can display the firewall rules. #>
get-command *firewall*
# ANSWER
Get-NetFirewallRule

<# Review the help for the command that displays the firewall rules. #>
# ANSWER
Get-Help Get-NetFirewallRule -showwindow

<# Display a list of the firewall rules that are enabled. #>
# ANSWER
Get-NetFirewallRule -Enabled

<# Display the same data in a table, making sure no information is truncated. #>
# ANSWER
Get-NetFirewallRule -Enabled true | Format-Table -wrap

<# Display a list of the enabled firewall rules. Display only the rules’ display names, the profiles they belong to, their directions, and whether they allow or deny access. #>
get-netfirewallrule -Enabled True | Select-Object -property *
# ANSWER
Get-NetFireWallRule -Enabled True | Select-Object DisplayName, Profile, direction, action | Format-List

<# Sort the list in alphabetical order first by profile and then by display name, with the results displaying in a separate table for each profile. #>
get-help sort-object -showwindow
get-help group-object -ShowWindow
Get-NetFirewallRule -Enabled True | Select-Object DisplayName, Profile, Direction, Action | Sort-Object -Property @{Expression = "Profile"; Descending = $true}, @{Expression = "DisplayName"; Descending = $true}

Get-NetFirewallRule -Enabled True | Select-Object DisplayName, Profile, Direction, Action | Sort-Object -Property Profile, DisplayName | Format-Table -GroupBy Profile