#! /bin/bash

getToken()
{
source /SHELLSCRIPT/testscript/FX500_GetAuthenticationToken.sh

}

dateTime()
 {
   #Capture Current Date and Time for Service Discovery of 172.16.2.96

 AMPM=`date +"%r" | cut -d " " -f2`
 echo $AMPM
 HOUR=`date +"%r" | cut -d ":" -f1`
 echo $HOUR
 MIN=`date +"%r" | cut -d ":" -f2`
 result=`expr $MIN + 2`
 echo $result
 
 TIME=$HOUR:$result:$AMPM
 
 
 echo $TIME
 
 DATE=`date +%Y-%m-%d`
 
 echo $DATE

 }

devicePerf()
 {


   curl -k -i -H "Authorization: Bearer   $Token" -H "Content-Type: application/json"  -H "orgId: $orgId" -H "siteId: $siteId" -X POST -d '{"ipPool":{"fqdnAddress":[{"deviceId":"appsvr97-1","fqdn":"appsvr97-1.in.fixstream.com","ip":"182.1.97.10"},{"deviceId":"appsvr97-11","fqdn":"appsvr97-11.in.fixstream.com","ip":"182.1.97.11"},{"deviceId":"bgl-testsvr4","fqdn":null,"ip":"172.16.2.96"}],"maskRange":[],"ipRange":[]},"dsSelectedSiteId":"'$siteId'","dsSelectedOrganization":"'$orgId'","scheduleInfo":{"recurrence":"MINUTE","recurrenceMin":10,"recurrenceHour":"","scheduleDate":"'$DATE'","scheduleTime":"'$TIME'","scheduleEndDate":null,"scheduleEndTime":null},"triggerType":"SERVER_MONITORING","createdBy":"Admin","discoveredDeviceType":"true","requestName":"device-performacne"}'   https://172.16.2.175/api/v2/dataCollector/schedule/

 }

getToken
dateTime

devicePerf
