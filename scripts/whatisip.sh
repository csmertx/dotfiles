#!/bin/bash

# csmertx 2023
# sed for COUNTRY might need some adjustment
# Uses dig command: sudo apt-get install dnsutils
IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
url="https://ipaddress.pro/"
url_local="/home/$USER/.scripts/whatip.txt"
wget -q -O- "$url" > $url_local
ISP="$( cat "$url_local" | grep "ISP" | tr ',' '\
' | grep "$P_ISP" | sed -r 's/^\s+//g'  |sed 's/<[^>]*>//g;s/ISP//g')"
COUNTRY="$( cat "$url_local" | grep "Country" | sed -r 's/^\s+//g'  | sed 's/<[^>]*>//g;s/Country//g;s/[][]//g;s/US//g')"
CITY="$( cat "$url_local" | grep "City" | tr ',' '\
' | grep "$P_CITY" | sed 's/<[^>]*>//g;s/[()]//g;s/[0-9]//g;s/City//g' | sed -r 's/\s+$//g;s/^\s+//g')"
STATE="$( cat "$url_local" | grep "State" | tr ',' '\
' | grep "$P_STATE" | awk '{print substr($1,40)}' | sed 's/[<>]//g;s/td//g;s/tr//g;s/img//g;s/[/]//g' | tr -d '\n')"
#;$s/.$//
STATE2="$( cat "$url_local" | grep "State" | tr ',' '\
' | grep "$P_STATE" | awk '{print substr($1,40)}' | sed 's/[<>]//g;s/td//g;s/tr//g;s/img//g;s/[/]//g;s/[d]$//' | tr -d '\n')"

printf "\n"
echo -e "   IP Address\n   ! $IP\n"
echo -e "   Internet Service Provider\n   ! $ISP\n"
echo -e "   Country\n   ! $COUNTRY\n"
echo -e "   City/Provence, State\n   ! $CITY, $STATE2\n"
