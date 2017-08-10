#! /bin/bash

getToken()
{
source /SHELLSCRIPT/testscript/FX500_GetAuthenticationToken.sh

}


deviceHide()
 {


   curl -k -i -H "Authorization: Bearer   $Token" -H "Content-Type: application/json"  -H "orgId: $orgId" -H "siteId: $siteId" -X PUT  -d '{"deviceIds":["bgl-testsvr4"]}' https://172.16.2.175/api/v2/devices/purge

 }


verifyHide()
 {
   curl -k -i  -H "Authorization: Bearer  $Token" -H "Content-Type: application/json" -H "orgId: $orgId" -H "siteId: $siteId"  -X POST  https://172.16.2.175/api/v2/devices/purged | grep "172.16.2.96"


    if [ $? -eq 0 ]; then
       
         echo "172.16.2.96 Hide Successfully" > /tmp/logs

     else

	echo "172.16.2.96 Hide Operation Failed" > /tmp/logs

    fi


 }
getToken

deviceHide

verifyHide
