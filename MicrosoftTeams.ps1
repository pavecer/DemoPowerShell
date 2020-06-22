Connect-MicrosoftTeams -Credential $credential

# Ma pod sebou vsecha nasataveni v ramci tymu, to co bylo puvodne v napriklad Get-TeamMemberSettings
Get-Team -GroupId 380ac9ed-7c46-48ec-ae1d-201d2864431f | select *
Get-Team
# Vlastnosti Teams kanalu, velmi omezene moznosti nastaveni
Get-TeamChannel -GroupId 380ac9ed-7c46-48ec-ae1d-201d2864431f


Get-CsPolicyPackage
Get-CsUserPolicyPackage -Identity "AllanD@KrtekCompany.OnMicrosoft.com"

#Vytvoreni tymu a kanalu ze sablony v ramci PowerShell
$teamName = "Test25"
$channels = @(
    "Project X",
    "Project Y"
)
$users = @(
    "AllanD@KrtekCompany.OnMicrosoft.com",
    "NestorW@KrtekCompany.OnMicrosoft.com"
       )
# V pripade, ze tym neexistuje tak jej vytvorime
$team = Get-Team | Where-Object { $_.DisplayName -eq $teamName }
if (-not $team) {
    Write-Host "Creating team $teamName..."
    $team = New-Team -DisplayName $TeamName
}
# Kontrola jiz prirazenych uzivatelu v pripade existujiciho tymu a naskladneni novych kousku dle $users
$existingUsers = Get-TeamUser -GroupId $team.GroupId | Select-Object -ExpandProperty User
$users | Where-Object { $_ -notin $existingUsers } | ForEach-Object {
    Write-Host "Adding user $_"
    Add-TeamUser -GroupId $team.GroupId -User $_ -Role Member -Verbose
}
# Vytvoreni kanalu dle promenne $channels do daneho tymu
$existingChannels = Get-TeamChannel -GroupId $team.GroupId | Select-Object -ExpandProperty DisplayName
$channels | Where-Object { $_ -notin $existingChannels } | ForEach-Object {
    Write-Host "Creating channel '$_'"
    New-TeamChannel -GroupId $team.GroupId -DisplayName $_
}
       
# Write-Host "Team GroupId: $($team.GroupId)"
# Get-TeamChannel -GroupId $team.GroupId | Select-Object DisplayName, Id | Out-Host