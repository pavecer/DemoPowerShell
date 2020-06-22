
#===================================================================================
# Sandbox playground, nezobrazovat
get-msoluser -UserPrincipalName "AllanD@KrtekCompany.OnMicrosoft.com" | select *
get-msoluser -all | select userprincipalname, objectid

New-MsolGroup -DisplayName "Demo Teams Production" -Description "Teams Production Group for users assign"

Add-MsolGroupMember -GroupObjectId $groups.objectid -GroupMemberObjectId 34998344-88fa-41c8-acfb-a80c86dce4bb -GroupMemberType User 


Get-Command -Name *add-msolgroup*
$groups = Get-MsolGroup | ?{$_.displayname -like "*Teams Pilot*"}
$groups
Get-MsolGroupMember -GroupObjectId $groups.objectid


(Get-MsolAccountSku).accountSkuId[1]
$userLicenses = (get-msoluser -UserPrincipalName "NestorW@KrtekCompany.OnMicrosoft.com").Licenses
$userLicenses.servicestatus
$userServicePlan = ($userLicenses.ServiceStatus | ?{$_.ServicePlan.ServiceName -eq "TEAMS1"}).ServicePlan.ServiceName
($userLicenses.ServiceStatus | ?{$_.ProvisioningStatus -eq "Disabled" -and $_.ServicePlan.ServiceName -ne "TEAMS1"}).ServicePlan.ServiceName
$userServicePlan

Set-MsolUserPassword -UserPrincipalName "JoniS@KrtekCompany.OnMicrosoft.com" -NewPassword Password1234 -ForceChangePassword $true