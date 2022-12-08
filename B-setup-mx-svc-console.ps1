# -------------------------------------------------------------
# STEP 3&4: Installing Service Console and Deploying a Mendix app 
# -------------------------------------------------------------

# set path to C:\Mendix directory which has been created above
# this will be used to store all Mendix projects in this demo  
# create directory for storing mendix apps


# Mendix Service Console UI
#       Select C:\Mendix as the location for apps
#
#
#       Service Configuration
#               service name = MendixDemo
#               description = MendixDemo (make sure the name of the app in the service console is showing as MendixDemo)  
#               user = see above
#               pwd = see above
#  
#
#
#       Project Files
#               locate .mda file
#               'download server'
#
#       Setup DB               
#               db type = postgres
#               localhost
#               name: MendixDemo
#               username=postgres, pw=test
#               if needed, troubleshoot connectivity with postgres  
#               psql "host=localhost port=5432 dbname=postgres user=postgres password=test"
#
#       set java path on C:\ProgramFiles\eclipse\...\hotspot
#

#       start service
#       when prompted, agree to creating the new 'MendixDemo' db.


#       navigate to localhost:8080 and ensure the app is being served
#       by the Mendix Service Console