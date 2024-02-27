#!/bin/bash

# Requires terminal emulator with emoji support (Konsole, Yakuake, etc.)
# Automate with Crontab, Systemd, etc.

# ex: crontab -e
# 0 */1 * * * /home/user/.scripts/moon_phase.sh
# Add to Tmux theme via: #( cat '/dev/shm/moon_phase_parsed.txt')
# Or however you add scripts to Tmux

TADMP="https://www.moongiant.com/phase/today/"
TXTPARSE="/dev/shm/timeanddate.html"
MOON_PHASE_PARSED="/dev/shm/moon_phase_parsed.txt"

## Download page to parse
wget -cO - "$TADMP" > "$TXTPARSE"

## Moon Phase illumination percentage
TADMPI="$(cat "$TXTPARSE" | grep "%" | sed -n '1p' | sed 's/.*-//' | sed 's/".*//g' | awk '{print $4}' | sed 's/ //g')"

## TADMPI test
#echo -en "\nIllumination Percentage is: $TADMPI\n"

## Moon Phase Status
TADMPS="$(cat "$TXTPARSE" | grep "%" | sed -n '1p' | sed 's/.*-//' | sed 's/with.*//g' | sed 's/ //g')"

## TADMPS test
#echo -en "\nMoon Phase Status is: $TADMPS\n"

## Change Moon icon based on status/visual

#First Quarter:   🌓
#Waxing Crecent:  🌒
#New Moon:        🌑
#Waning Crecent:  🌘
#Third Quarter:   🌗
#Waning Gibbous:  🌖
#Full Moon:       🌕
#Waxing Gibbous:  🌔

# Swap Moon Emoji

if [[ "$TADMPS" == "FirstQuarter" ]]; then
    MOONICON="🌓"
elif [[ "$TADMPS" == "WaxingCrecent" ]]; then
    MOONICON="🌒"
elif [[ "$TADMPS" == "NewMoon" ]]; then
    MOONICON="🌑"
elif [[ "$TADMPS" == "WaningCrecent" ]]; then
    MOONICON="🌘"
elif [[ "$TADMPS" == "ThirdQuarter" ]]; then
    MOONICON="🌗"
elif [[ "$TADMPS" == "WaningGibbous" ]]; then
    MOONICON="🌖"
elif [[ "$TADMPS" == "FullMoon" ]]; then
    MOONICON="🌕"
elif [[ "$TADMPS" == "WaxingGibbous" ]]; then
    MOONICON="🌔"
else
    echo -en "No Data (?)"
fi

# Print to temp file

echo -en "Moon: $TADMPI $MOONICON" > "$MOON_PHASE_PARSED"
cd ~
exit 0
