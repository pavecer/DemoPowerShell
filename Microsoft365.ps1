# Pripojeni se do MSOL
Connect-MsolService -Credential $credential

# Reset hesla u uzivatele
Get-MsolUser -All | ft UserPrincipalName,UsageLocation,isLicensed

Set-MsolUserPassword -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" -NewPassword Password1234 -ForceChangePassword $true
Set-MsolUserPassword -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" -ForceChangePasswordOnly $true

$tenantLicenses = (Get-MsolAccountSku).accountSkuId

# Prirazeni licence uzivateli
Set-MsolUserLicense -UserPrincipalName $userPN -AddLicenses $tenantLicenses[1]

# Moznost modifikace licence a odebrani servisniho planu pro Teams
$userPN="NestorW@KrtekCompany.OnMicrosoft.com"
$licenseOption = New-MsolLicenseOptions -AccountSkuId KrtekCompany:ENTERPRISEPREMIUM -DisabledPlans TEAMS1
#Prirazeni konkretni licence na jednoho uzivatele
Set-MsolUserLicense -UserPrincipalName $userPN -AddLicenses $tenantLicenses[1] -LicenseOptions $licenseOption
#Kontrola prirazene licence bez planu TEAMS1 pro Nestora
(get-msoluser -UserPrincipalName $userPN).Licenses.ServiceStatus

# Odebrani vsech priprazenych licenci u uzivatele
#https://docs.microsoft.com/en-us/powershell/module/msonline/set-msoluserlicense?view=azureadps-1.0
$userPN = "NestorW@KrtekCompany.OnMicrosoft.com"
$userLicenses = (Get-MsolUser -UserPrincipalName $userPN).Licenses

foreach ($item in $userLicenses) {
    Set-MsolUserLicense -UserPrincipalName $userPN -removeLicenses $item.accountSkuId 
}

# Kontrola licenci, ktere po odebrani uzivately zustali
Get-MsolUser -UserPrincipalName $userPN | select Licenses


# Zalozeni pilotni skupiny pro prirazeni licenci uzivatelum
$newgroupid = (New-MsolGroup -DisplayName "Demo Teams Production" -Description "Teams Pilot Group for users assign").objectid
# Kontrola toho zda-li skupina existuje
Get-MsolGroup -ObjectId $newgroupid

# Vylistovani vsech uzivatelu v tenantu a jejich objectid
get-msoluser -all | select userprincipalname, objectid

# Naskladneni novych uzivatelu do skupiny
Add-MsolGroupMember -GroupObjectId $newgroupid -GroupMemberObjectId 34998344-88fa-41c8-acfb-a80c86dce4bb -GroupMemberType User


# Vyhledani a odstraneni skupiny, kterou jsme zalozili
Remove-MsolGroup -ObjectId (Get-MsolGroup | ?{$_.displayname -like "*Teams Production*"}).objectid -Force


#Remove-MsolGroup -ObjectId e6cb2c25-3d65-4426-aee1-5109bac9e839 -Force
