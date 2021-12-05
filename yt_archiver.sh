#!/bin/bash

### This script requires the following software
### yt-dlp: https://github.com/yt-dlp/yt-dlp#installation
### imagemagick
### libnotify4 (arch: libnotify)

#### May fail with certain subtitles (CNN, etc.)
#### One may override embedding subtitles with: yt_archiver URL --nosubs

## This script downloads specified YouTube video, and applies creator thumbnail,
## and auto generated or creator made subtitles to metadata
## Example command: ./script.sh "super-neat-yt-video-url.com"
## All files download to: $ytviddir
## Generating a cookies.txt file can be done with Firefox extension: Cookies.txt
## I use alias ytd: alias ytd="/home/$HOME/.scripts/yt_archiver.sh" via .bashrc

##### Using this in a way that hammers Google servers (10 calls/second+)
##### may distrupt your access to the YouTube api and or YouTube.

### Tested fine for English subtitles (more or less--could be hot mess)
### Might need work for other languages, and it might fail on fresh
### videos (YT takes a few minutes to auto generate subtitles 30-60min)

## The variables
ytdurl="$1"
ytfn="$(yt-dlp $ytdurl -o "%(title)s" --get-filename)"
ytviddir="$HOME/Videos/YouTube"
cookiez="$HOME/cookies.txt"

## Subtitles (default 1 is yes)
## Override with: yt_archiver $ytdurl --nosubs
if [[ "$2" == "--nosubs" ]]; then
    ysubl=0
else
    ysubl=1
fi

## Subtitle Language choice
subl="en"

## Display video title
echo -e "\n\nFetching: $ytfn\n\n"
sleep 1

## Start the download process
yt-dlp -F $ytdurl
echo -en "\n\nVideo resolution choice? => "
read vf
clear

if [[ $ysubl -gt 0 ]]; then
    ## Check for creator subtitles
    yt-dlp --write-auto-sub --sub-lang $subl --skip-download $ytdurl > $ytviddir/yt_archiver.txt
    sleep 1
    if [[ "$(cat $ytviddir/yt_archiver.txt | grep vtt)" ]]; then
        ytdsub="--write-auto-sub"
        rm -f $ytviddir/yt_archiver.txt
    else
        ytdsub="--write-sub"
        rm -f $ytviddir/yt_archiver.txt
    fi

    ## Do the thing, and echo the notification.  Errors echo to stdout
    if [[ $vf -gt 1 ]]; then
        cd $ytviddir && yt-dlp --write-thumbnail $ytdsub --convert-subs=srt --sub-lang $subl --cookies $cookiez -f $vf "$ytdurl" -o '%(title)s.%(ext)s'
        convert "${ytfn}.webp" "${ytfn}.png"
        ffmpeg -i "${ytfn}.mp4" -i "${ytfn}.${subl}.srt" -c copy -c:s mov_text "${ytfn}_.mp4"
        rm -f "${ytfn}.mp4"
        ffmpeg -i "${ytfn}_.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}.mp4"
        rm -f "${ytfn}_.mp4"
        notify-send -u normal -i video "$(echo -e "YT Download Complete:\n$ytfn")"
        rm -f "${ytfn}.png"
        rm -f "${ytfn}.webp"
        rm -f "${ytfn}.${subl}.srt"
    else
        echo -en "\n\nNo format specified.  This script works best with mp4."
    fi
else
    if [[ $vf -gt 1 ]]; then
        cd $ytviddir && yt-dlp --write-thumbnail --cookies $cookiez -f $vf "$ytdurl" -o '%(title)s.%(ext)s'
        convert "${ytfn}.webp" "${ytfn}.png"
        ffmpeg -i "${ytfn}.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}_.mp4"
        mv "${ytfn}_.mp4" "${ytfn}.mp4"
        notify-send -u normal -i video "$(echo -e "YT Download Complete:\n$ytfn")"
        rm -f "${ytfn}.png"
        rm -f "${ytfn}.webp"
    else
        echo -en "\n\nNo format specified.  This script works best with mp4."
    fi
fi
