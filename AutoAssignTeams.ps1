$domainname = "KrtekCompany.OnMicrosoft.com"
#$credname = ""
#$location = "CZ"
#$accounSKUId = "KrtekCompany:ENTERPRISEPREMIUM"
$servicePlanToEnable = "TEAMS1"
#$cred = get-aitomationPSCredential -name $credname

$allusers = Get-MsolUser -all -DomainName $domainname
$groups = Get-MsolGroup | Where-Object {$_.displayname -like "*Teams Pilot*"}

foreach ($group in $groups){
    $members = Get-MsolGroupMember -GroupObjectId $group.objectid
    foreach ($user in $allusers){
        $userUPN = $user.UserPrincipalName
        if ($members.emailaddress -contains $user.userprincipalname){
            $userLicenses = (get-msoluser -UserPrincipalName $userUPN).Licenses
            if ($userLicenses){
            $userServicePlan = ($userLicenses.ServiceStatus | Where-Object {$_.ProvisioningStatus -eq "Success" -and $_.ServicePlan.ServiceName -eq $servicePlanToEnable}).ServicePlan.ServiceName
            if ($userServicePlan){
                Write-Host "Uzivatel "$userUPN" jiz ma MS Teams aktivovane."
            } else {
                Write-Host "Uzivatel "$userUPN" nema MS Teams sluzbu, aktivuji..."
                $disabledOptions = ($userLicenses.ServiceStatus | where-object {$_.ProvisioningStatus -eq "Disabled" -and $_.ServicePlan.ServiceName -ne $servicePlanToEnable}).ServicePlan.servicename
                $setLicenseOption = New-MsolLicenseOptions -AccountSkuId $userLicenses.AccountSkuId -DisabledPlans $disabledOptions
                Set-MsolUserLicense -UserPrincipalName $userUPN -LicenseOptions $setLicenseOption
                Write-Host "Sluzba "$servicePlanToEnable" byla pro uzivatele "$userUPN" uspesne aktivovana." 
               
            }
            } else {
                Write-Host "Uzivatel "$userUPN" nema zadnou licenci, prirazuji...."
                # Misto pro prirazeni licence, kde je aktivovan MS Teams
            }
        }
    }
}

# Disablovani MS Teams u uzivatele Nestora
<#
$userPN="NestorW@KrtekCompany.OnMicrosoft.com"
$licenseOption = New-MsolLicenseOptions -AccountSkuId KrtekCompany:ENTERPRISEPREMIUM -DisabledPlans TEAMS1
Set-MsolUserLicense -UserPrincipalName $userPN -LicenseOptions $licenseOption
#>