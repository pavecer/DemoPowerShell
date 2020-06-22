# Pripojeni se do MSOL
Connect-MsolService -Credential $credential

# Reset hesla u uzivatele
Get-MsolUser -All | ft UserPrincipalName,UsageLocation,isLicensed

Set-MsolUserPassword -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" -NewPassword Password1234 -ForceChangePassword $true
Set-MsolUserPassword -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" -ForceChangePasswordOnly $true

$tenantLicenses = (Get-MsolAccountSku).accountSkuId

# Prirazeni licence uzivateli
Set-MsolUserLicense -UserPrincipalName $userPN -AddLicenses $tenantLicenses[1]

# Odebrani vsech priprazenych licenci u uzivatele
#https://docs.microsoft.com/en-us/powershell/module/msonline/set-msoluserlicense?view=azureadps-1.0
$userPN = "AllanD@KrtekCompany.OnMicrosoft.com"
$userLicenses = (Get-MsolUser -UserPrincipalName $userPN).Licenses

foreach ($item in $userLicenses) {
    Set-MsolUserLicense -UserPrincipalName $userPN -removeLicenses $item.accountSkuId 
}

# Kontrola licenci, ktere po odebrani uzivately zustali
Get-MsolUser -UserPrincipalName $userPN | select Licenses

