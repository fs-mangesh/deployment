#! /bin/bash


#Data file Holds Latest Build Number

touch > /172.16.2.201/FixStream-Cluster/data

#readMail.py Script is responsible for Cont.. readming and updating (Mark as READ) user emails, If the mail contains Build Info it will Store in Data File

python /172.16.2.201/FixStream-Cluster/readMail.py > /172.16.2.201/FixStream-Cluster/data


#BUILD=`cat data  | grep "Meridian Build" | tr -s " " |   cut -d ":" -f6 | cut -d "-" -f2 | cut -d " " -f2`

#Storing Latest Build Number 

BUILD=`cat /root/FixStream/data | grep "Meridian Build" | cut -d "-" -f15 | cut -d " " -f2`

#Check If the Build has Numerical value and is not empty, if empty script will exit with Status 9

if [ -z != $BUILD  ]

then


#Build Historic Data

echo $BUILD >> /172.16.2.201/FixStream-Cluster/log

#Update Latest Buld number in env Variable

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/deployNC

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/deployDC-1

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/deployDC-2

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/License

mail -s "Powering On NC and DC Vm's  " mangesh.bharsakle@afourtech.com < /dev/null

#This Python Script is responsible for PoweringOff, revertSnapshot and PowerON Server Machines [NC-DC Vm's].

python /172.16.2.201/FixStream-Cluster/ESXI.py

#Wait till Vm's PowerON

sleep 1m

mail -s "Powered On NC and DC Vm's " mangesh.bharsakle@afourtech.com < /dev/null

#NC=`nc -z 172.16.2.175 22`

#DC=`nc -z 172.16.2.176 22`

sleep 2m


mail -s "NCE Worker 172.16.2.202 and 172.16.2.203 Deployment Started" mangesh.bharsakle@afourtech.com < /dev/null

#Simultaniously Run Worker Process

python /172.16.2.201/FixStream-Cluster/workerNC-1.py  

python /172.16.2.201/FixStream-Cluster/workerNC-2.py 

#Validate Whether Worker is Running 

mail -s "NCE Worker 172.16.2.202 and 172.16.2.203 Deployed " mangesh.bharsakle@afourtech.com < /dev/null

sleep 1m 

#Deploy NCE Master .

mail -s "NCE Master 172.16.5.201 Deployment Started " mangesh.bharsakle@afourtech.com < /dev/null

python /172.16.2.201/FixStream-Cluster/masterNC.py

mail -s "NCE Master 172.16.5.201 Deployed " mangesh.bharsakle@afourtech.com < /dev/null

sleep 1m

#Deploy Multiple DC's Simultaniously

mail -s "DC 172.16.5.204 and 172.16.5.205  Deployment Started" mangesh.bharsakle@afourtech.com < /dev/null

python /172.16.2.201/FixStream-Cluster/siteDC-1.py

python /172.16.2.201/FixStream-Cluster/siteDC-2.py

#Validate Whether DC Installed Successfully

mail -s "DC 172.16.5.204 and 172.16.5.205  Deployed " mangesh.bharsakle@afourtech.com < /dev/null

sleep 1m 

mail -s "Uploadning Licence" mangesh.bharsakle@afourtech.com < /dev/null

python /172.16.2.201/FixStream-Cluster/Licence.py

#Validate Whether License uploded Successfully

mail -s "Meridian Installation Compleated!!" mangesh.bharsakle@afourtech.com < /dev/null


else

 exit 9

fi

