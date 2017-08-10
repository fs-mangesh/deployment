#! /bin/bash


#Data file Holds Latest Build Number

touch > /Mangesh/172.16.5.201/data

#readMail.py Script is responsible for Cont.. readming and updating (Mark as READ) user emails, If the mail contains Build Info it will Store in Data File

python /Mangesh/172.16.5.201/readMail.py > /Mangesh/172.16.5.201/data


#BUILD=`cat data  | grep "Meridian Build" | tr -s " " |   cut -d ":" -f6 | cut -d "-" -f2 | cut -d " " -f2`

#Storing Latest Build Number 

BUILD=`cat /Mangesh/172.16.5.201/data | grep "Meridian Build" | cut -d "-" -f15 | cut -d " " -f2`



#BUILD=`cat data | grep "deploy,"  | tr -s " " | cut -d "@" -f2 | cut -d "," -f3`

#meridianSender=`cat data | grep "deploy,"  | tr -s " " | cut -d "<" -f2 | cut -d ">" -f1`

#Check If the Build has Numerical value and is not empty, if empty script will exit with Status 9

if [ -z != $BUILD  ]

then


#Build Historic Data

echo $BUILD >> /Mangesh/172.16.5.201/log

#Update Latest Buld number in env Variable

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/deployNC

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/deployDC-1

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/deployDC-2

sed -i "1s/.*/export VERSION=$BUILD/" /usr/share/squirrelmail/cluster/License

mail -s "Powering On NC and DC Vm's  " $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

#This Python Script is responsible for PoweringOff, revertSnapshot and PowerON Server Machines [NC-DC Vm's].

python /Mangesh/172.16.5.201/ESXI.py

#Wait till Vm's PowerON

sleep 1m

mail -s "Powered On NC and DC Vm's " $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

#NC=`nc -z 172.16.2.175 22`

#DC=`nc -z 172.16.2.176 22`

sleep 2m


mail -s "NCE Worker 172.16.2.202 and 172.16.2.203 Deployment Started" $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

#Simultaniously Run Worker Process

python /Mangesh/172.16.5.201/workerNC-1.py  &

mail -s "NCE Worker 172.16.2.202" mangesh.bharsakle@afourtech.com  < /dev/null

python /Mangesh/172.16.5.201/workerNC-2.py 
mail -s "NCE Worker 172.16.2.203" mangesh.bharsakle@afourtech.com  < /dev/nul

#Validate Whether Worker is Running 

mail -s "NCE Worker 172.16.2.202 and 172.16.2.203 Deployed " $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

sleep 1m 

#Deploy NCE Master .

mail -s "NCE Master 172.16.5.201 Deployment Started " $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

python /Mangesh/172.16.5.201/masterNC.py

mail -s "NCE Master 172.16.5.201 Deployed " $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

sleep 1m

#Deploy Multiple DC's Simultaniously

mail -s "DC 172.16.5.204 and 172.16.5.205  Deployment Started" $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

python /Mangesh/172.16.5.201/siteDC-1.py  &

python /Mangesh/172.16.5.201/siteDC-2.py

#Validate Whether DC Installed Successfully

mail -s "DC 172.16.5.204 and 172.16.5.205  Deployed " $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

sleep 1m 

mail -s "Uploadning Licence" $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null

python /Mangesh/172.16.5.201/Licence.py

#Validate Whether License uploded Successfully

mail -s "Meridian Installation Compleated!!" $meridianSender  mangesh.bharsakle@afourtech.com  < /dev/null


else

 exit 9

fi

