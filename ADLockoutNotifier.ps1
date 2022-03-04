$Username = "";
$Password = "";
$ToEmail="";

    $domainAdmins = get-adgroupmember 'domain admins' | select samaccountname
    $domainAdmins = $domainAdmins -replace '\@{samaccountname='
    $domainAdmins = $domainAdmins -replace '\}'
    $domainAdmins = $domainAdmins 
    write-host "Checking to see if any of these users are locked out:"; 
    $domainAdmins
   
    $AccountLockOutEvent = Get-EventLog -LogName "Security" -InstanceID 4740 -Newest 1
    $LockedAccount = $($AccountLockOutEvent.ReplacementStrings[0])
    $AccountLockOutEventTime = $AccountLockOutEvent.TimeGenerated
    $AccountLockOutEventMessage = $AccountLockOutEvent.Message

    if($domainAdmins -contains $LockedAccount ){
        $message = new-object Net.Mail.MailMessage;
        $message.From = $Username;
        $message.To.Add($ToEmail);
        $message.Subject = "Account Locked Out: $LockedAccount";
        $message.Body = "Account $LockedAccount was locked out on $AccountLockOutEventTime.`n`nEvent Details:`n`n$AccountLockOutEventMessage";

        $smtp = new-object Net.Mail.SmtpClient("smtp.office365.com", "587");
        $smtp.EnableSSL = $true;
        $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
        $smtp.send($message);

        write-host "$LockedAccount was locked out. Email Sent"; 
    }else{
         write-host "$LockedAccount is not in notify list";
    }