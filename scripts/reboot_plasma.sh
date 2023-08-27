#!/bin/bash

echo -en "\n\nSaving KDE Plasma Session\n\n"
sleep 1

qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.saveCurrentSession

echo -en "\n\nKDE Plasma Session Saved\n\nRebooting...\n\n"
sleep 1

echo -en "\n\nContinue? (Y/N) => "
read doordonotthereisnotry

if [[ "$doordonotthereisnotry" == "y" || "$doordonotthereisnotry" == "Y" ]]; then
    clear
    sleep 2
    echo -en "\n\nRebooting. Please allow up to two minutes to reboot.\n\n"
    sleep 10
    reboot
else
    echo -en "\n\nReboot Cancelled.\n\n"
fi
#reboot
