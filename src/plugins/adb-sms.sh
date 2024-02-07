#!/bin/sh
IPX="$1" #Replace with IP or device ID
echo -e "====================="
echo -e "SMS from device: ${IPX}"
echo -e "====================="
adb -s "$IPX" shell content query --uri content://sms --projection _id,body
echo -e "====================="
