# Nazev tenantu, ktery je nasledne vyuzit na pripojeni do ShP admin site
$orgName="krtekcompany"
# Pripojeni do ShP Online
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $credential

# Pro pripojeni v pripade pouziti MFA staci
Connect-SPOService -Url https://$orgName-admin.sharepoint.com

# Prehled existujicich ShP site kolekci
Get-SPOSite
# Prehled uzivatelu pro jednotlive site kolekce
Get-SPOUser -Site "https://krtekcompany.sharepoint.com/" 

# Vytvoreni nove ShP site kolekce
Get-SPOWebTemplate


New-SPOSite -Template "STS#3" -Owner "admin@krtekcompany.onmicrosoft.com" `
-Url "https://krtekcompany.sharepoint.com/teams/newsite1" -Title "New Site 1" -StorageQuota 10000

Get-SPOSite "https://krtekcompany.sharepoint.com/teams/newsite1" | select *


# Prehled vsech odstranenych ShP site
Get-SPODeletedSite