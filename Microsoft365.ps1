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
Set-MsolUserLicense -UserPrincipalName $userPN -LicenseOptions $licenseOption
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
$newgroupid = (New-MsolGroup -DisplayName "Demo Teams Pilot" -Description "Teams Pilot Group for users assign").objectid
# Kontrola toho zda-li skupina existuje
Get-MsolGroup -ObjectId $newgroupid

# Vylistovani vsech uzivatelu v tenantu a jejich objectid
get-msoluser -all | select-object userprincipalname, objectid

# Naskladneni novych uzivatelu do skupiny
Add-MsolGroupMember -GroupObjectId $newgroupid -GroupMemberObjectId 97d3df27-5f1f-480f-809d-d4e0bdcd7707 -GroupMemberType User


# Vyhledani a odstraneni skupiny, kterou jsme zalozili
Remove-MsolGroup -ObjectId (Get-MsolGroup | where-object {$_.displayname -like "*Teams Pilot*"}).objectid -Force


#Remove-MsolGroup -ObjectId e6cb2c25-3d65-4426-aee1-5109bac9e839 -Force
