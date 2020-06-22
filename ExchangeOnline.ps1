# Prihlaseni do EOL
Connect-ExchangeOnline -Credential $credential

# Kontrola po prihlaseni, vylistovani emailu (nedelat nad velkym tenantem!!)
Get-Mailbox -ResultSize unlimited

# Nastaveni domeny
$domainname = "KrtekCompany.OnMicrosoft.com"
# Prepinac pro zalozeni noveho kontaktu, v pripade ze se bude preposilat mimo
$externalMailbox = $false
# Nastaveni identity na ktere se auto reply zapne
$identity = "JoniS@"+$domainname
# Nastaveni identity kam bude smerovat pripadne prepsilani
$remoteemail ="AllanD@"+$domainname
# Datum od - do
$startDate = "6.1.2020"
$endDate = "12.31.2020"
# Nastaveni pro vytvoreni externiho kontaktu, kam se pripadne posta bude posilat
$kontakt = "pavel.vecer@outlook.com"
$kontaktName= "Pavel Vecer [External]"
# Vycteni aktualniho nastaveni mailoxu, kde se bude OoO nastavovat
$userMailbox = Get-Mailbox -Identity $identity
# Nastaveni reply zpravy
$reply = "<html><head></head><body><p>Dobrý den,<br>Prosím veškerou komunikaci určenou pro "+$userMailbox.DisplayName+" ("+$identity+") směřujte na email: <a href='mailto:'"+$remoteemail+">"+$remoteemail+"</a>.<br><b>Váš email byl přeposlán!</b></p></body></html>"

# Jeden smer pro vytvoreni noveho kontaktu a nastaveni forwardu
if($externalMailbox){
    New-MailContact -Name $kontaktName -ExternalEmailAddress $kontakt
    Set-MailContact -Identity $kontaktName -HiddenFromAddressListsEnabled $true
    Set-MailboxAutoReplyConfiguration -Identity $identity -AutoReplyState Scheduled -StartTime $startDate -EndTime $endDate -AutoDeclineFutureRequestsWhenOOF $true -InternalMessage $reply -ExternalMessage $reply
    Set-Mailbox -Identity $identity -ForwardingAddress $kontakt -DeliverToMailboxAndForward $true
# Druhy smer, pouze pro nastaveni forwardu
}else {
    Set-MailboxAutoReplyConfiguration -Identity $identity -AutoReplyState Scheduled -StartTime $startDate -EndTime $endDate -AutoDeclineFutureRequestsWhenOOF $true -InternalMessage $reply -ExternalMessage $reply
    Set-Mailbox -Identity $identity -ForwardingAddress $remoteemail -DeliverToMailboxAndForward $true
       
}

#Get-Mailbox -Identity $identity
# Check nastaveni nad danym mailboxem	
Get-MailboxAutoReplyConfiguration -Identity $identity
