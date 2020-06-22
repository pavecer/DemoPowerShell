Connect-MsolService -Credential $credential
Connect-ExchangeOnline -Credential $credential

Get-MsolUser -all
Get-Mailbox -ResultSize unlimited

Get-Mailbox -Identity "AllanD@KrtekCompany.OnMicrosoft.com" | select *logon*

Get-MsolUser -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" | select *logon*

Get-MailboxStatistics -Identity "NestorW@KrtekCompany.OnMicrosoft.com" | select *

Get-MsolUser -all | Select-Object  DisplayName, @{Name="LogonTime"; Expression={(Get-MailboxStatistics -Identity $_.UserPrincipalName).LastUserActionTime}}