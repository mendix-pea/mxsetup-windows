
# README
This script was created to automate the manual setup described here: 
https://docs.mendix.com/developerportal/deploy/deploy-mendix-on-microsoft-windows/


# Warning 
> Please note that this setup is for **Mendix demo or POC purposes** only. Windows Server Datacenter 2016, 2019 and 2022 were used to test and develop this script.

<br><br>


# Setup

- Log on to your Windows VM/server as administrator.

- Copy the following files from your computer to the server desktop. These are also provided in the <code>bin/</code> folder for your convenience.
    - .mda you wish to deploy
    - .exe for Mendix Service Console installer.
    <br><br>
    
- Copy the three Powershell scripts A, B and C onto the server desktop. 
<br><br>

- Search for 'Windows Powershell ISE (integrated scripting environment)' and launch it as administrator. Drag the scripts A, B, C into the ISE to open them. 
<br><br>

- Script A
    - Hit the play button (Run Script, F5). This will start installing the prerequisites one by one, as indicated by the progress messages in console below. The whole script should take approximately 15 minutes or so. Postgres installation takes the longest (about 10 minutes). The script may seem stuck at this step, but please be patient and let the script finish.
    <br><br>

- Script B
    - These steps are to be followed manually because we have not yet found a way to automate the installation of the Mendix Service Console.

    - Run the service console installer and enter details as discussed in the guidelines.
    <br><br>

- Script C

