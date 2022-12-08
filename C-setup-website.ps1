# local user for running mendix service console as a service 
$svcUser = "mendix"
$svcUserPwd = ConvertTo-SecureString("M3nd1x1234!") -AsPlainText -Force

# -------------------------------------------------------------
# STEP 5: Configuring IIS Server 
# -------------------------------------------------------------
Import-Module WebAdministration
cd IIS:\Sites
Stop-Website -Name '.\Default Web Site'

# 5.1 - activating proxy in ARR
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.webServer/proxy" -name "enabled" -value "True"

New-Website -Name 'MendixDemo' -PhysicalPath 'C:\Mendix\Apps\MendixDemo\Project\web\' -Port 80
Start-Website -Name '.\MendixDemo'

# 5.3 - Set HTTPS binding
# TODO

# 5.4 - Configuring MIME types
If (!(Get-WebConfigurationProperty -pspath $site -filter "system.webServer/staticContent" -Name collection[fileExtension=".json"])) {
        Add-WebConfigurationProperty -PSPath $site -Filter "system.webServer/staticContent" -Name "." -Value @{fileExtension='.json';mimeType='application/json'}
}
If (!(Get-WebConfigurationProperty -pspath $site -filter "system.webServer/staticContent" -Name collection[fileExtension=".mxf"])) {
        Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/staticContent" -name "." -value @{fileExtension='.mxf';mimeType='text/xml'}

}

# 5.5 - set url rewriting rules 
$site = 'IIS:\Sites\MendixDemo'
$mxPath = 'http://localhost:8080/{R:1}{R:2}'

# 5.5.1 - reverse proxy inbound rules
$ruleName = 'xas'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(xas/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'ws'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(ws/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'ws-doc'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(ws-doc/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'file'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(file/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'link'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(link/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'rest'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(rest/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'rest-doc'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(rest-doc/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'debugger'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(debugger/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

$ruleName = 'oauth'
Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName;stopProcessing='True'}
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value "^(oauth/)(.*)"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "type" -value "Rewrite"
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/action" -name "url" -value $mxPath

# 5.5.2 - proto header rule for accessing swagger documentation
# $ruleName = 'add x-forwarded-proto header'
# Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules" -name "." -value @{name=$ruleName}
# Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/match" -name "url" -value ".*"
# # 'MatchAll' and 'False' are defaults so, condition is omitted from the config. Try setting non-defaults and then resetting for this condition to show up.
# Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/conditions" -name "logicalGrouping" -value "MatchAny"
# Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/conditions" -name "trackAllCaptures" -value "True"
# Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/conditions" -name "logicalGrouping" -value "MatchAll"
# Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/conditions" -name "trackAllCaptures" -value "False"
# Add-WebConfigurationProperty -pspath $site  -filter "system.webServer/rewrite/rules/rule[@name='$ruleName']/serverVariables" -name "." -value @{name='HTTP_X_FORWARDED_PROTO';value='https'}


# 5.5.3 - (Optional) Redirect HTTP to HTTPS 
# TODO

# 5.6 Disable client cache
Set-WebConfigurationProperty -pspath $site  -filter "system.webServer/staticContent/clientCache" -name "cacheControlMode" -value "DisableCache"

# 6 -  Preserving host header
# TODO

# Delete default website
Remove-Website '.\Default Web Site'

# de-elevate Powershell permissions
# Set-ExecutionPolicy $originalExecPolicy.value__