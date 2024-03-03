#!/bin/bash

## Works with specific filename formatting
# 1. French 79 - Between the Buttons (Olympic).mp3

### Example Usage
## $ script "/home/user/music/albumpath"

## Album art types: JPG or PNG (copy to albumpath)
## Need to convert from webp?
# KDE Plasme Users: https://csmertx.github.io/Linux/Software/dolphin/#custom-right-click-menu

MP3DIR="$1"

cd "$MP3DIR"

echo -en "\n\nArtist name please ==> "
read ARTISTTAG

echo -en "\n\nAlbum title please ==> "
read ALBUMTAG

NMP3DIR="${ALBUMTAG}_tagged"
mkdir "$NMP3DIR"

SPCTAG=$(echo "$ALBUMTAG" | awk '{print substr($0,1,1)}')

echo -en "\n\nYear of album please ==> "
read ALBUMY

echo -en "\n\nAm I working with a png or jpg? ==> "
read ALBUMAFT

ALBUMART="$(find *.${ALBUMAFT} 2> /dev/null)"

for f in *.mp3;
do
    SONGTAG="$(echo "$f" | sed "s/.*- //g" | sed "s/${SPCTAG}.*//g")"
    TRACKNUM="$(echo "$f" | cut -d . -f 1)"
    id3v2 -a "$ARTISTTAG" -A "$ALBUMTAG" -t "$SONGTAG" -y "$ALBUMY" -T "$TRACKNUM" "$f"
    ffmpeg -i "$f" -i "$ALBUMART" -map_metadata 0 -map 0 -map 1 "${NMP3DIR}/${f}"
    sleep 1
done
