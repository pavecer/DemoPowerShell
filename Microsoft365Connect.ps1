#Hledani modulu v PowerShell galerii
Find-Module -Name azuread*

Get-PSRepository
Get-InstalledModule

# Jako prvni je potreba nainstalovat vsechny potrebne moduly
Install-Module MSOnline -Scope CurrentUser

# Import-Module MSOnline

# Ziskani pristupovych udaju
$credential = Get-Credential -UserName "admin@KrtekCompany.onmicrosoft.com" -Message "Login"

Connect-MsolService -Credential $credential

# Reset hesla u uzivatele
Get-MsolUser -All


Set-MsolUserPassword -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" -NewPassword Password1234 -ForceChangePassword $true
Set-MsolUserPassword -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" -ForceChangePasswordOnly $true



