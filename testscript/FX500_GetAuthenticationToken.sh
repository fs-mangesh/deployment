#! /bin/bash

#Log file Location

LOG_FILE="/SHELLSCRIPT/logs/"

DATA_FILE="/SHELLSCRIPT/data/rest"


 getToken()
 {
        ## all Meridian REST service API to get Auth Token


           Token=`curl -k -s  -d "client_id=fixstreamapp&grant_type=password&password=admin098&scope=read%2Cwrite%2Ctrust&username=superadmin&client_secret=fixstream" https://172.16.2.175/oauth/token | cut -d ":" -f2 | cut -d "," -f1 | cut -d "\"" -f2`
 
        # Store Organization ID in orgId

           orgId=`curl -k -i -s -H "Authorization: Bearer  $Token" https://172.16.2.175/api/v2/sites | tail -2 | cut -d "," -f1,3 | cut -d "," -f1 | cut -d "\"" -f6 | cut -d " " -f2 | tail -1`

   #Store Site ID in siteId

           siteId=`curl -k -i -s  -H "Authorization: Bearer  $Token" https://172.16.2.175/api/v2/sites | tail -2 | cut -d "," -f1,3 | cut -d "," -f2 | cut -d "\"" -f6 | cut -d " " -f2 | tail -1`


        export Token
        export orgId
        export siteId
}



getToken

