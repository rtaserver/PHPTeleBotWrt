#!/bin/sh
IPX="$1" #Replace with IP or device ID
DS="5" #Delay reenabling network
echo -e "====================="
echo -e "Device [${IPX}] status"
echo -e "====================="
adb -s "$IPX" shell dumpsys battery | grep "level\|powered"
echo -e "====================="
echo -e "Signal Info"
echo -e "====================="
adb -s "$IPX" shell dumpsys telephony.registry | grep -i 'signalstrength' | sed -e 's/,/\n/g' -e 's/ mMnc=//g' -e 's/mMcc=/\nPLMN=/g' -e 's/mAlphaLong=/\nISP Name (Long)=/g' -e 's/mAlphaShort=/\nISP Name (Short)=/g' 
echo -e "====================="