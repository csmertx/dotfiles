#!/bin/bash

## Works with specific filename formatting
# 1. French 79 - Between the Buttons (Olympic).mp3

MP3DIR="$1"
cd "$MP3DIR"
ALBUMART="$(find *.jpg)"

if [[ $ALBUMART == "" ]]; then
    ALBUMART="$(find *.png)"
fi

echo -en "\n\nArtist name please ==> "
read ARTISTTAG

echo -en "\n\nAlbum title please ==> "
read ALBUMTAG

NMP3DIR="${ALBUMTAG}_tagged"
mkdir $NMP3DIR

SPCTAG=$(echo $ALBUMTAG | awk '{print substr($0,1,1)}')

echo -en "\n\nYear of album please ==> "
read ALBUMY

for f in *.mp3;
do
    SONGTAG="$(echo "$f" | sed "s/.*- //g" | sed "s/(${SPCTAG}.*//g")"
    TRACKNUM="$(echo "$f" | cut -d . -f 1)"
    id3v2 -a "$ARTISTTAG" -A "$ALBUMTAG" -t "$SONGTAG" -y "$ALBUMY" -T "$TRACKNUM" "$f"
    ffmpeg -i "$f" -i "$ALBUMART" -map_metadata 0 -map 0 -map 1 "${NMP3DIR}/${f}"
    sleep 1
done
