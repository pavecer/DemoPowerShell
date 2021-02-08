# Prihlaseni do sessiony Teamsu
Import-Module MicrosoftTeams
$sfbSession = New-CsOnlineSession
Import-PSSession $sfbSession


# Nastaveni politiky na nahravani schuzek do OfB/ShP
Set-CsTeamsMeetingPolicy -Identity Global -RecordingStorageMode "OneDriveForBusiness"
# Nastaveni politiky na nahravani schuzek do Stream
Set-CsTeamsMeetingPolicy -Identity Global -RecordingStorageMode "Stream"
# Kontrola vsech nastaveni viz nize vypsano
Get-CsTeamsMeetingPolicy -Identity Global

<#
Identity                                   : Global
Description                                :
AllowChannelMeetingScheduling              : True
AllowMeetNow                               : True
AllowPrivateMeetNow                        : True
MeetingChatEnabledType                     : Enabled
LiveCaptionsEnabledType                    : DisabledUserOverride
DesignatedPresenterRoleMode                : EveryoneUserOverride
AllowIPAudio                               : True
AllowIPVideo                               : True
AllowEngagementReport                      : Enabled
AllowTrackingInReport                      : Enabled
IPAudioMode                                : EnabledOutgoingIncoming
IPVideoMode                                : EnabledOutgoingIncoming
AllowAnonymousUsersToDialOut               : False
AllowAnonymousUsersToStartMeeting          : False
AllowPrivateMeetingScheduling              : True
AutoAdmittedUsers                          : EveryoneInCompany
AllowCloudRecording                        : True
AllowRecordingStorageOutsideRegion         : False
RecordingStorageMode                       : OneDriveForBusiness
AllowOutlookAddIn                          : True
AllowPowerPointSharing                     : True
AllowParticipantGiveRequestControl         : True
AllowExternalParticipantGiveRequestControl : False
AllowSharedNotes                           : True
AllowWhiteboard                            : True
AllowTranscription                         : False
MediaBitRateKb                             : 50000
ScreenSharingMode                          : EntireScreen
VideoFiltersMode                           : AllFilters
AllowPSTNUsersToBypassLobby                : False
AllowOrganizersToOverrideLobbySettings     : False
PreferredMeetingProviderForIslandsMode     : TeamsAndSfb
AllowNDIStreaming                          : False
AllowUserToJoinExternalMeeting             : Disabled
SpeakerAttributionMode                     : EnabledUserOverride
EnrollUserOverride                         : Disabled
RoomAttributeUserOverride                  : Off
StreamingAttendeeMode                      : Disabled
AllowBreakoutRooms                         : True
TeamsCameraFarEndPTZMode                   : Disabled
AllowMeetingReactions                      : True
AllowMeetingRegistration                   : True
WhoCanRegister                             : EveryoneInCompany
AllowScreenContentDigitization             : Enabled
#>

# Nastaveni hierarchie pro moznost delegovani tasku
# Aktualne je dostupne pouze v preview verzi Teams modulu - https://www.powershellgallery.com/packages/MicrosoftTeams/1.1.10-preview
# Je potreba instalovat posledni dostupny modul

Set-TeamTargetingHierarchy -FilePath "C:\Users\pavecer\OneDrive - Microsoft\06 Microsoft Teams\13 Novinky Teams 2021\ContosoTeamSchema.csv"
# Kontrola nastaveni hierarchie v Teamsech
Get-TeamTargetingHierarchyStatus
# V pripade chyby je mozne se podivat co se nepovedlo
(Get-TeamTargetingHierarchyStatus).ErrorDetails.ErrorMessage
# Odebrani nastavene hierarchie
Remove-TeamTargetingHierarchy


# Na unorove OH
Get-CsTeamsMeetingPolicy -Identity global | fl identity, AllowMeetingRea*
