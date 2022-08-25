#!/bin/bash

### This script requires the following software
### yt-dlp: https://github.com/yt-dlp/yt-dlp#installation
### imagemagick
### libnotify4 (arch: libnotify)

#### yt-archiver_ns.sh == Version for videos without subtitles to DL

## This script downloads specified YouTube video, and applies creator thumbnail,
## Example command: ./script.sh "super-neat-yt-video-url.com"
## All files download to: $ytviddir
## Generating a cookies.txt file can be done with Firefox extension: Cookies.txt
## I use alias ytdns: alias ytdns="/home/$HOME/.scripts/yt_archiver_ns.sh" via .bashrc

##### Using this in a way that hammers Google servers (10 calls/second+)
##### may distrupt your access to the YouTube api and or YouTube.

## The variables
ytdurl="$1"
ytfn="$(yt-dlp $ytdurl -o "%(title)s" --get-filename)"
ytviddir="$HOME/Videos/YouTube"
cookiez="$HOME/cookies.txt"
cd $ytviddir

## Display video title
echo -e "\n\nFetching: $ytfn\n\n"
sleep 1

## Start the download process
yt-dlp -F $ytdurl
echo -en "\n\nVideo resolution choice? => "
read vf
clear

if [[ $vf -gt 1 ]]; then
    yt-dlp --write-thumbnail --cookies $cookiez -f $vf "$ytdurl" -o '%(title)s.%(ext)s'
    convert "${ytfn}.webp" "${ytfn}.png"
    ffmpeg -i "${ytfn}.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}_.mp4"
    mv "${ytfn}_.mp4" "${ytfn}.mp4"
        if [[ -f "${ytfn}.mp4" ]]; then
            notify-send -u normal -i video "$(echo -e "YT Download Complete:\n$ytfn")"
        else
            notify-send -u normal -i video "$(echo -e "YT Download Failed:\n$ytfn")"
        fi
    rm -f "${ytfn}.png"
    rm -f "${ytfn}.webp"
else
    echo -en "\n\nNo format specified.  This script works best with mp4."
fi

