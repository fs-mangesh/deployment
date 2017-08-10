#! /bin/bash


#Confiure SMTP Server Details

getToken()
{
source /SHELLSCRIPT/testscript/FX500_GetAuthenticationToken.sh
   
}
smtpServer()
 {
  curl -k -i -H "Authorization: Bearer  $Token" -H "Content-Type: application/json" -H "orgId: $orgID" -H "siteId: $siteID" -X POST -d  '{"smtpEmailConfig":"true","smtpHostName":"smtp.office365.com","smtpAuthUser":"no-reply@fixstream.com","smtpAuthPwd":"FixStream123","mailSmtpPort":"587","smtpAuthConfig":"true","smtpTlsConfig":"true","mailFrom":"no-reply@fixstream.com","type":"save"}' https://172.16.2.175/api/v2/users/emailConfiguration/\?mailFrom\=no-reply@fixstream.com\&mailSmtpPort\=587\&smtpAuthConfig\=true\&smtpAuthPwd\=FixStream123\&smtpAuthUser\=no-reply@fixstream.com\&smtpEmailConfig\=true\&smtpHostName\=smtp.office365.com\&smtpTlsConfig\=true\&type\=save

 
 }

getToken
smtpServer
