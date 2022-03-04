# ADLockoutNotifier
Get notified when a Domain Admin Active Directory account is locked out via email

Works with Office365

Configure Sender Email/Password, and the receiver emails within the script

You can also, create a scheduled task within task scheduler.
 Steps:
  1: Create Basic Task
  2: Confirure name and description
  3: Set Trigger to: "When a specific event is logged"
  4: Log: "Security, Source: "Microsoft Windows Security Auditing", Event ID: "4740"
  5: Action: "Start a program"
  6: Program/script: "powershell.exe", Add arguments: "-nologo -File C:\Path\ADLockoutNotifier.ps1"
  7: Finished
  

