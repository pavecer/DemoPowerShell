# Prihlaseni se do Exchange Online a do MS Online
try {
    Import-Module MSOnline -ErrorAction Stop
} catch {
    Install-Package MSOnline -Scope CurrentUser
    Import-Module MSOnline
}
try {
    Import-Module ExchangeOnlineManagement -ErrorAction Stop
} catch {
    Install-Package ExchangeOnlineManagement -Scope CurrentUser
    Import-Module ExchangeOnlineManagement
}
Connect-MsolService -Credential $credential
Connect-ExchangeOnline -Credential $credential

# Kontrola, vylistovani si uzivatelu pro MSOL a EXO
Get-MsolUser -all
Get-Mailbox -ResultSize unlimited

# Vyhledani jedne schranky a property logon
Get-Mailbox -Identity "AllanD@KrtekCompany.OnMicrosoft.com" | Select-Object *logon*

# Vyhledani jednoho uzivatele a property logon
Get-MsolUser -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" | Select-Object *logon*

# Vyhledani uzivatele a jeho property 
Get-MailboxStatistics -Identity "NestorW@KrtekCompany.OnMicrosoft.com" | Select-Object *

# Propojeni property ze dvou dotazu pres calculated property 
Get-MsolUser -all | Select-Object  DisplayName, @{Name="LogonTime"; Expression={(Get-MailboxStatistics -Identity $_.UserPrincipalName).LastUserActionTime}}

# Takto to nefunguje
Get-MsolUser -all | Get-MailboxStatistics -Identity $_.UserPrincipalName | Select-Object DisplayName, LastUserActionTime