#! /bin/bash

pid="$(pgrep -u chris vlc)"
vlcid="$(lsof -p $(pidof -s vlc) | grep -o "/.*\.mp4" | tail -1 | sed "s/ //g")"
logid="$(tail -n 1 "/home/chris/vlc_history.txt" | sed "s/.\{24\}//;s/ //g")"

if [ -z "$pid" ] ; then
 exit 0

elif [ "$vlcid" == "$logid" ] ; then
 exit 0

else
 lsof -p $(pidof -s vlc) | grep -o "/.*\.mp4" | tail -1 | sed "s/^/$(date +"%a %m-%d-%y %I:%M %p - ")/" >> "/home/chris/vlc_history.txt" && exit 0

fi

