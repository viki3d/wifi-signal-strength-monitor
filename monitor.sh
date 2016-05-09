#!/bin/sh

# WiFi Signal Strength Monitor
# Measures signal strength to given WiFi access point
# Created by Victor Kirov

echo "+------------------------------+";
echo "| WiFi Signal Strength Monitor |";
echo "+------------------------------+";
if [ $# = 2 ]
    then
        echo "Starting measuring signal strength for '"$2"' ";
        echo "Ctrl+C / Ctrl+Z to stop \n";
        counter=0
        while true; do
            counter=$(($counter+1));
            echo "Measurement #"$counter
            res=$(iwlist $1 scan | awk '/Quality/{ getline x; getline x; if (x~/[ ]+ESSID:\"'$2'\"/) { print x; print; } }')
            if [ ${#res} -eq 0 ]; then
                    echo "     No beacon captured from "$2" on this scan-try"
                else
                    echo "    "$res
            fi
            sleep 4
        done
    else
        echo "Usage: ";
        echo "sh monitor.sh wlan0 WiFiName";
        exit;
fi

