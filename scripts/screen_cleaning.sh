#!/bin/bash

# Requires: sxiv, xbacklight, and xdotool (apt-get sxiv xdotool xbacklight)

# For ~/.bashrc (launched with command: screenbg)
# function screenbg(){
#    /location of scripts/screen_cleaning.sh
#}

# Deactivate blue light filtering (may cause issues with KDE/Plasma Night Color
#sleep 1
#echo -en "\n\nAttempting to deactivate blue light filter app\n\n"
#qdbus org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.invokeShortcut "Toggle Night Color" 2>/dev/null
#pkill -USR1 redshift 2>/dev/null
#gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false 2>/dev/null

sleep 1
echo -en "\n\nFor better visibility please toggle blue light filtering app and set screen brightness to 100%. Press y when ready => "
read forthehoard

if [[ $forthehoard = [yY] ]]; then
    # Show screen background for screen cleaning
    sleep 1
    echo -en "\n\nDisplaying background in 5 seconds, please toggle Yakuake, Guake, etc. Press q to exit sxiv\n\n"
    sleep 5
    sxiv "/home/$USER/.scripts/screen_cleaning_background.png" 2>/dev/null &
    sleep 0.5
    xdotool key f
    sleep 0.5
    xdotool key b
else
    echo -en "\n\nExiting screen cleaning script..\n\n"
    sleep 2
    clear
    exit 1
fi


