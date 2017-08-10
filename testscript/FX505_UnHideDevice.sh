#! /bin/bash

getToken()
{
source /SHELLSCRIPT/testscript/FX500_GetAuthenticationToken.sh

}


deviceUnHide()
 {


   curl -k -i -H "Authorization: Bearer   $Token" -H "Content-Type: application/json"  -H "orgId: $orgId" -H "siteId: $siteId" -X PUT  -d '{"deviceIds":["bgl-testsvr4"]}' https://172.16.2.175/api/v2/devices/unpurge
    

 }


verifyHide()
 {
   curl -k -i  -H "Authorization: Bearer  $Token" -H "Content-Type: application/json" -H "orgId: $orgId" -H "siteId: $siteId"  -X POST  https://172.16.2.175/api/v2/devices/purged | grep "172.16.2.96"


    if [ $? -eq 0 ]; then
       
         echo "172.16.2.96 UnHide Operation Failed" > /tmp/logs

     else

	echo "172.16.2.96 Hide Operation Successfull" > /tmp/logs

    fi


 }
getToken

deviceUnHide

verifyHide
