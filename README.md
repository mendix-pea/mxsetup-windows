
# README
This script was created to automate the manual setup described here: 
https://docs.mendix.com/developerportal/deploy/deploy-mendix-on-microsoft-windows/


# Warning 
> Please note that this setup is for **Mendix demo or POC purposes** only. Windows Server Datacenter 2016, 2019 and 2022 were used to test and develop this script.

<br><br>


# Setup
<pre>

- Determine that your VM or server is allowed to receive traffic over port 80.
    

- Log on to your Windows VM/server as administrator.


- Copy the following files from your computer to the desktop of this machine:
    - .mda you wish to deploy
    - .exe for Mendix Service Console installer.
    

- Search for 'Windows Powershell ISE (integrated scripting environment)' and launch it as administrator. Paste the provided Powershell script and also save it to the desktop. Hit the play button (Run Script, F5) to run this script.


- The script will start installing the prerequisites one by one, as indicated by the progress messages in console. The whole script should take approximately 15 minutes or so to run. Of all the prerequisites, postgres takes the longest (about 10 minutes). So please be patient and let the script finish running.


</pre>