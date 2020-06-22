# Pripojeni se do AAD
Connect-AzureAD -Credential $Credential

# Vsechny informace u uzivateli z AAD
Get-AzureADUser -ObjectId $userPN | select *

# Odhlaseni ze vsech session a nasledne zablokovani prihlaseni
Get-AzureADUser -SearchString $userPN | Revoke-AzureADUserAllRefreshToken
# https://docs.microsoft.com/en-us/office365/enterprise/powershell/block-user-accounts-with-office-365-powershell
Set-AzureADUser -ObjectID $userPN -AccountEnabled $false
# https://docs.microsoft.com/en-us/powershell/module/AzureAD/Set-AzureADUser?view=azureadps-2.0
Get-AzureADUser -ObjectId $userPN | select AccountEnabled