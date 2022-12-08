
# README
This script was created to automate the manual setup described here: 
https://docs.mendix.com/developerportal/deploy/deploy-mendix-on-microsoft-windows/


# Warning 
> Please note that this setup is for **Mendix demo or POC purposes** only. Windows Server Datacenter 2016, 2019 and 2022 were used to test and develop this script.

<br><br>


# Setup

- Log on to your Windows VM/server as administrator.

- Copy all the files in this repo to the server desktop. 

- Search for 'Windows Powershell ISE (integrated scripting environment)' and launch it as administrator. Drag the scripts A, B, C into the ISE to open them. <br><br>


- Script A
    - Hit the play button (Run Script, F5). This will start installing the prerequisites one by one, as indicated by the progress messages in console below. The whole script should take approximately 15 minutes or so. Postgres installation takes the longest (about 10 minutes). The script may seem stuck at this step, but please be patient and let the script finish <br><br>


- Script B
    - These steps are to be followed manually because we have not yet found a way to automate the installation of the Mendix Service Console. Run the service console installer and enter details as discussed here.
    <br><br>


- Script C
    - Hit the play button (Run Script, F5). This will configure an IIS website as required. <br><br>

- In your browser, navigate to the IP address or DNS name of your server. It should serve the Mendix app over port 80. Make sure that your server is accessible over this port.
<br><br>

- You should be able to login to your app using the MxAdmin user. Its password can be set in the Mendix Service Console > Advanced Options. You will need to restart the service for the password change to become effective.<br><br>

