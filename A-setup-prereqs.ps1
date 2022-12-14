# local user for running mendix service console as a service 
$svcUser = "mendix"
$svcUserPwd = ConvertTo-SecureString("M3nd1x1234!") -AsPlainText -Force

# -------------------------------------------------------------
# Install Prerequisites 
# -------------------------------------------------------------
#
# install choco package manager in an elevated powershell
$originalExecPolicy = Get-ExecutionPolicy
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#
# IIS and required extensions
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
choco install iis-arr -y
choco install urlrewrite -y

# openjdk 11 required by Mendix Service Console 
choco install openjdk11 -y

# diagnostic
# chrome for local testing purposes
choco install googlechrome -y

# install a local postgres 14 database for a quick way to have a database for the Mendix app 
# this takes the longest (about 5-10 mins), so skip if using some other non-local database for this setup 
# username=postgres,pw=test
choco install postgresql14 --params '/Password:test /Port:5432' --ia '--enable-components server,commandlinetools' -y


# folder for storing all mendix apps
# to be selected when setting up the service console in the next step
New-Item -Path 'C:\' -Name 'Mendix' -ItemType Directory


# create local service user
# assign 'logon as service' permission
New-LocalUser -Name $svcUser -Password $svcUserPwd -Description "Local service account for Mendix Service Console" -FullName "Mendix Service Account User" -AccountNeverExpires -UserMayNotChangePassword 
choco install Carbon -y
Import-Module 'Carbon'
$Identity = $svcUser
$privilege = "SeServiceLogonRight"
$CarbonDllPath = "C:\Program Files\WindowsPowerShell\Modules\Carbon\bin\fullclr\Carbon.dll"
[Reflection.Assembly]::LoadFile($CarbonDllPath)
[Carbon.Security.Privilege]::GrantPrivileges($Identity, $privilege)