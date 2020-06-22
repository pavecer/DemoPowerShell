#Hledani modulu v PowerShell galerii
Find-Module -Name azuread*

# Informace o napojene repository a pripadny prehled vsech instalovanych modulu
Get-PSRepository
Get-InstalledModule

# Jako prvni je potreba nainstalovat vsechny potrebne moduly
# -Scope CurrentUser nam umoznuje instalovat v kontextu aktualniho uzivatele. Samotne moduly jsou pak dostupne $home\Documents\WindowsPowerShell\Modules
# https://docs.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-5.1
Install-Module MSOnline -Scope CurrentUser
Install-Module AzureADPreview -Scope CurrentUser
Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser
# Import-Module MSOnline

# Ziskani pristupovych udaju
$credential = Get-Credential -UserName "admin@KrtekCompany.onmicrosoft.com" -Message "Login"

# Dnes si budu hrat s timto uctem
$userPN = "AllanD@KrtekCompany.OnMicrosoft.com"



