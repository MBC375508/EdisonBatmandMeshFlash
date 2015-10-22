#!/bin/bash
# ensure you have the correct path to batmand.
clear
echo "Setting up Edison Batmand mesh"

echo ".... batmand ...."
cd /
./home/root/batmand/batmand -o 500 -s 10.42.0.1 wlan0

echo ".... mesh ...."

sleep 0.5

wpa_cli -iwlan0 disconnect
wpa_cli -iwlan0 remove_network all
wpa_cli -iwlan0 add_network
wpa_cli -iwlan0 set_network 0 frequency 2412
wpa_cli -iwlan0 set_network 0 mode 1
wpa_cli -iwlan0 set_network 0 ssid '"CSPLMESH"'
wpa_cli -iwlan0 set_network 0 auth_alg OPEN
wpa_cli -iwlan0 set_network 0 key_mgmt NONE
wpa_cli -iwlan0 set_network 0 scan_ssid 1
wpa_cli -iwlan0 select_network 0
wpa_cli -iwlan0 enable_network 0
wpa_cli -iwlan0 status
udhcpd wlan0

sleep 0.5

clear
echo ".... Result ...."
wpa_cli -iwlan0 status

sleep 0.5

ifconfig wlan0

echo "done"
