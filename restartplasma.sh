#!/bin/bash

echo -en "\n\nWas I loaded from Konsole? (y/n) ==> "
read iskonsole

if [[ "$iskonsole" == "n" ]]; then
    echo -en "\n\nPlease try again, I prefer Konsole..\n\n"
    exit 0
else
    notify-send -u critical "Refreshing Plasma Desktop"
    sleep 2
    killall plasmashell
    sleep 5
    kstart5 plasmashell
    notify-send -u critical "Plasma Desktop Refreshment Complete"
fi
