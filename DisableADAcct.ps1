#Author: Reggie Wilson
#Last Edited: 1/18/2022
#This script will disalbe an AD account and move it to the Disabled Users OU


cls

import-Module ActiveDirectory

Add-Type -AssemblyName System.Web

#Input username of user AD account to be disabled
$Username = Read-Host -Prompt "Enter username of AD account to disable"

#Confirm User account to delete
	get-aduser $Username
	write-host "Press Enter to Continue if you would like to delete this AD account. Otherwise close this window."

	pause
	
#Disable AD account
Disable-ADAccount -Identity $Username


#Get new user distinguished name and assign it to a variable
    #get-aduser $Username -Properties DistinguishedName | select -expand DistinguishedName
    $DistinguishedName = get-aduser $Username -Properties DistinguishedName | select -expand DistinguishedName
	
#Move AD account to Disabled
$Target = "OU"
Move-ADObject -Identity $DistinguishedName -TargetPath $Target

