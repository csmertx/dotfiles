#!/bin/bash

# Requires terminal emulator with emoji support (Konsole, Yakuake, etc.)
# Automate with Crontab, Systemd, etc.

# ex: crontab -e
# 0 */1 * * * /home/user/.scripts/moon_phase.sh
# Add to Tmux theme via: #(cat '/dev/shm/moon_phase_parsed.txt')
# Or however you add scripts to Tmux

## Download moongiant.com/phase/today/ to save on website requests
TADMP="https://www.moongiant.com/phase/today/"
TXTPARSE="/dev/shm/timeanddate.html"
MOON_PHASE_PARSED="/dev/shm/moon_phase_parsed.txt"

## Download page to parse
wget -cO - "$TADMP" > "$TXTPARSE"

## Moon Phase illumination percentage
TADMPI="$(cat "$TXTPARSE" | grep "%" | sed -n '1p' | sed 's/.*-//' | sed 's/".*//g' | awk '{print $4}' | sed 's/ //g')"

## Moon Phase Status
TADMPS="$(cat "$TXTPARSE" | grep "%" | sed -n '1p' | sed 's/.*-//' | sed 's/with.*//g' | sed 's/ //g')"

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
## Illumicon for New Moon awareness

if [[ "$TADMPS" == "FirstQuarter" ]]; then
    MOONICON="🌓"
    ILLUMICON="▲"
elif [[ "$TADMPS" == "WaxingCrescent" ]]; then
    MOONICON="🌒"
    ILLUMICON="▲"
elif [[ "$TADMPS" == "NewMoon" ]]; then
    MOONICON="🌑"
    ILLUMICON="🔦"
elif [[ "$TADMPS" == "WaningCrescent" ]]; then
    MOONICON="🌘"
    ILLUMICON="▼"
elif [[ "$TADMPS" == "LastQuarter" ]]; then
    MOONICON="🌗"
    ILLUMICON="▼"
elif [[ "$TADMPS" == "WaningGibbous" ]]; then
    MOONICON="🌖"
    ILLUMICON="▼"
elif [[ "$TADMPS" == "FullMoon" ]]; then
    MOONICON="🌕"
    ILLUMICON="🐺"
elif [[ "$TADMPS" == "WaxingGibbous" ]]; then
    MOONICON="🌔"
    ILLUMICON="▲"
else
    echo -en "No Data (?)"
fi

# Print to temp RAM file
echo -en "Moon: $ILLUMICON $TADMPI $MOONICON" > "$MOON_PHASE_PARSED"
exit 0
