#!/bin/bash

### This script requires the following software
### yt-dlp: https://github.com/yt-dlp/yt-dlp#installation
### imagemagick
### libnotify4 (arch: libnotify)
##### Using this in a way that hammers Google servers (10 calls/second+)
##### may distrupt your access to the YouTube api and or YouTube.

## This script downloads specified YouTube video, and applies creator thumbnail,
## and auto generated subtitles to metadata
## Example command: ./script.sh "super-neat-yt-video-url.com"
## All files download to: $ytviddir
## Generating a cookies.txt file can be done with Firefox extension: Cookies.txt
## For best video/audio leave video resolution choice blank (just like using yt-dlp directly)
## I use alias ytd: alias ytd="/home/$HOME/.scripts/yt_archiver.sh" via .bashrc

## The variables
ytdurl="$1"
ytfn="$(yt-dlp $ytdurl -o "%(title)s" --get-filename)"
ytviddir="$HOME/Videos/YouTube"
cookiez="$HOME/cookies.txt"

## Subtitle Language choice
subl="en"

## Grab video title
echo -e "\n\nFetching: $ytfn"
sleep 1
yt-dlp -F $ytdurl
echo -en "\n\nVideo resolution choice? => "
read vf
clear

## Do the thing, and echo the notification.  Errors echo to stdout
if [[ "$vf" -gt 1 ]]; then
    cd $ytviddir && yt-dlp --write-thumbnail --write-auto-sub --convert-subs=srt --sub-lang $subl --cookies $cookiez -f $vf $ytdurl -o '%(title)s.%(ext)s'
    convert "${ytfn}.webp" "${ytfn}.png"
    ffmpeg -i "${ytfn}.mp4" -i "${ytfn}.${subl}.srt" -c copy -c:s mov_text "${ytfn}_.mp4"
    rm -f "${ytfn}.mp4"
    ffmpeg -i "${ytfn}_.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}.mp4"
    rm -f "${ytfn}_.mp4"
    notify-send -u normal -i video "$(echo -e "YT Download Complete:\n$ytfn")"
    rm -f "${ytfn}.png"
    rm -f "${ytfn}.webp"
    rm -f "${ytfn}.${subl}.srt"
    #mv "${ytfn}_.mp4" "${ytfn}.mp4"
elif [[ "$vf" == "" ]]; then
    cd $ytviddir && yt-dlp --write-thumbnail --write-auto-sub --convert-subs=srt --sub-lang $subl --cookies $cookiez $ytdurl -o '%(title)s.%(ext)s'
    convert "${ytfn}.webp" "${ytfn}.png"
    ffmpeg -i "${ytfn}.mp4" -i "${ytfn}.${subl}.srt" -c copy -c:s mov_text ${ytfn}_.mp4
    rm -f "${ytfn}.mp4"
    ffmpeg -i "${ytfn}_.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}.mp4"
    rm -f "${ytfn}_.mp4"
    notify-send -u normal -i vido "$(echo -e "YT Download Complete:\n$ytfn")"
    rm -f "${ytfn}.png"
    rm -f "${ytfn}.webp"
    rm -f "${ytfn}.${subl}.srt"
    #mv "${ytfn}_.mp4" "${ytfn}.mp4"
else
    echo -en "/n/nNo instructions provided.  Do or do not, there is no try."
fi
