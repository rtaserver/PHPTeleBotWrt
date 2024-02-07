#!/bin/sh
IPX="$1" #Replace with IP or device ID
DS="5" #Delay reenabling network
echo -e "Connecting to ${IPX} device..." 
echo -e "Airplane mode is at DISABLED state, will be enabled in ${DS} secs..."
if [[ "$(adb -s ${IPX} shell settings get global airplane_mode_on)" == "0" ]]; then
	adb -s "$IPX" settings put global airplane_mode_on 1 &>/dev/null
	adb -s "$IPX" am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true &>/dev/null
fi
if [[ "$(adb -s ${IPX} shell cmd connectivity airplane-mode)" == "disabled" ]]; then
	adb -s "$IPX" shell cmd connectivity airplane-mode enable &>/dev/null
fi
sleep "${DS}" &>/dev/null

echo "Disabling airplane mode to get new IP and refreshed network..."
if [[  "$(adb -s ${IPX} shell settings get global airplane_mode_on)" == "1" ]]; then
	adb -s "$IPX" settings put global airplane_mode_on 0 &>/dev/null
	adb -s "$IPX" am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false &>/dev/null
fi
if [[ "$(adb -s ${IPX} shell cmd connectivity airplane-mode)" == "enabled" ]]; then
	adb -s "$IPX" shell cmd connectivity airplane-mode disable &>/dev/null
fi
sleep 1 &>/dev/null
echo "Network refreshed done...!!"