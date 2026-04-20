#!/bin/bash

#DC383838 - Wardriving Script
#Autor: Dion Mulaj - Th3Mayh3m
#Pershkrim: Ky script automatizon procesin e wardriving permes GPSD dhe KISMET. Scripta eshte e bazuar ne projektet e ndryshme te wardriving

# Terminimi i hostapd per te ndalur AP mode dhe per te kaluar ne monitoring mode
pkill hostapd

# Ndalimi i proceseve egzistuese te GPSD dhe KISMET per evitimin e konflikteve ne monitorim
pkill gpsd
pkill kismet

# Ndalimi i WiFi interfaces per t'u kthyer ne monitoring mode
ifconfig wlan1 down
ifconfig wlan2 down

# Startimi i modulit te GPSD
echo "Starting GPSD....."
gpsd -n /dev/ttyACM0
sleep 1
echo "Waiting for GPS lock....."

# Monitorimi i statusit dhe percaktimi i koordinatave 2D/3D te GPS/GLONASS
gpspipe -w | grep -qm 1 '"mode":[23]'
echo "GPS lock acquired!"

# Sinkronizimi i kohes se sistemit me kohen e GPS/GLONASS per timestamps ne logsat e KISMET
UTCDATE=`gpspipe -w | grep -m 1 "TPV" | sed -r 's/.*"time":"([^"]*)".*/\1/' | sed -e 's/^\(.\{10\}\)T\(.\{8\}\).*/\1 \2/'`
date -u -s "$UTCDATE"

# Konfigurimi i monitoring mode ne WiFi interfaces dhe startimi i KISMET DAEMON
iwconfig wlan1 mode Monitor
iwconfig wlan2 mode Monitor
kismet -p /root/kismetlogs -t wardrive --override wardrive -c wlan1 -c wlan2 --gps=gpsd:host=localhost,port=2947
