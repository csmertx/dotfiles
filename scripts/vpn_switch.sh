#!/bin/bash
VPN="$(echo | sudo systemctl is-active openvpn-client@client.service)"
IN="inactive"
AC="active"

if [ $VPN == $AC ]; then
    sudo systemctl stop openvpn-client@client.service ; notify-send -u critical "VPN DISCONNECTED"

elif [ $VPN == $IN ]; then
    sudo systemctl start openvpn-client@client.service ; notify-send -u critical "VPN CONNECTING"
fi

