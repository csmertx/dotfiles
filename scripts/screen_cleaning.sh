#!/bin/bash

# Requires: sxiv and xdotool (apt-get sxiv xdotool)

echo -en "\n\nDisplaying background in 5 seconds, please close Yakuake, Guake, etc. Press q to exit sxiv (image viewer)\n\n"
sleep 5
sxiv "/home/$USER/.scripts/screen_cleaning_background.png" 2>/dev/null &
sleep 0.5
xdotool key f
sleep 0.5
xdotool key b
