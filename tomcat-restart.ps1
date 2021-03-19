$Today = ((Get-Date).ToString('yyyy-MM-dd'))
$TOMCAT_DOCNIX= "D:\Tomcat 8.5\"
$STATUS = Get-Service Tomcat8
Stop-Service -Name "Tomcat8"
$STATUS.WaitForStatus('Stopped')
New-Item -ItemType Directory -Path "$TOMCAT_DOCNIX\logs\$Today"
Move-Item -Path $TOMCAT_DOCNIX\logs\*.log -Destination $TOMCAT_DOCNIX\logs\$Today
Move-Item -Path $TOMCAT_DOCNIX\logs\*.txt -Destination $TOMCAT_DOCNIX\logs\$Today
Move-Item -Path $TOMCAT_DOCNIX\logs\*.gz -Destination $TOMCAT_DOCNIX\logs\$Today
Remove-Item –path $TOMCAT_DOCNIX\work\* –recurse
Remove-Item –path $TOMCAT_DOCNIX\temp\* –recurse
Start-Service -Name "Tomcat8"