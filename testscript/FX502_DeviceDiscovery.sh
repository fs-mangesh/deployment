#! /bin/bash




getToken()
{
source /SHELLSCRIPT/testscript/FX500_GetAuthenticationToken.sh

}

deviceDiscovery()
 {

   while read line; do

ip=$line

echo $ip


curl -k -i -H "Authorization: Bearer $Token"    -H "Content-Type: application/json"   -H "orgId: $orgId" -H "siteId: $siteId" -X POST -d  '{"ipPool":{"ipRange":[{"ipAddressFrom":"","ipAddressTo":""}],"maskRange":[],"fqdnAddress":[{"ip":"'$ip'","fqdn":""}]},"dsSelectedSiteId":"'$siteId'","dsSelectedOrganization":"'$orgId'","triggerType":"NETWORK_DISCOVERY","scheduleInfo":{"recurrence":"NOW","scheduleDate":"","scheduleTime":"","scheduleTimeAMPM":"","scheduleEndDate":"","scheduleEndTime":"","scheduleEndTimeAMPM":"","recurrenceMin":"","recurrenceHour":""},"communityStringInfo":[],"authList":[{"ssh":true,"telnet":"","username":"root","password":"FixStream","sshkey":"","windows":"","api":"","jumpServer":"","userProfile":"","jumpServeripAddress":""}],"enabledPasswordList":[{"enablePassword":""}],"discoveredDeviceType":"true","applicationProperties":{"openstackDetails":[]},"resetCredentials":false,"ignorePing":false,"isIgnoreDevices":false,"requestName":"'$ip'"}' https://172.16.2.175/api/v2/dataCollector/schedule/ >> requestIDS

done < /SHELLSCRIPT/inventory/ips


  
 }

getToken

deviceDiscovery
