#!/bin/bash

### This script requires the following software
### yt-dlp: https://github.com/yt-dlp/yt-dlp#installation
### imagemagick
### libnotify4 (arch: libnotify)
### ffmpeg (merges thumbnail, subtitles, and m4a audio to final video file--up to 1080p 60fps)
### Jellyfin for local network streaming

#### May fail with certain subtitles (CNN, etc.)

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

## Allow the use of exclamations in Bash used by Linux Mint or Debian(s)
set +H

## The variables
ytdurl="$1"
ytfn="$(yt-dlp $ytdurl -o "%(title)s" --get-filename)"
ytviddir="$HOME/Videos/YouTube"
#ytviddir="$HOME/Videos/FreeCad"
cookiez="$HOME/cookies.txt"
ytm4a="${RANDOM}.m4a"
ytdf="${RANDOM}.txt"
ytthumb="${RANDOM}"

cd $ytviddir

## Override with: yt_archiver $ytdurl --nosubs
if [[ "$2" == "--nosubs" ]]; then
    ysubl=0
else
    ysubl=1
fi

## Subtitle Language choice
subl="en"

## Audio Language check (140,140-0,140-14,140-drc= English)
if [[ "$(yt-dlp --list-formats "$1" | grep "140-0")" ]]; then
    ytaf="140-0"
elif [[ "$(yt-dlp --list-formats "$1" | grep "140-14")" ]]; then
    ytaf="140-14"
elif [[ "$(yt-dlp --list-formats "$1" | grep "140-drc")" ]]; then
    ytaf="140-drc"
else
    ytaf="140"
fi

## Display video title
echo -e "\n\n==> Fetching: $ytfn\n\n"
sleep 1

## Start the download process
yt-dlp -F $ytdurl
echo -en "\n\nVideo resolution choice? => "
read vf
clear

if [[ $ysubl -gt 0 ]]; then
    ## Check for creator subtitles
    yt-dlp --write-auto-sub --sub-lang $subl --skip-download $ytdurl > $ytviddir/${ytdf}
    sleep 1
    if [[ "$(cat $ytviddir/${ytdf} | grep vtt)" ]]; then
        ytdsub="--write-auto-sub"
    else
        ytdsub="--write-sub"
        #rm -f $ytviddir/${ytdf}
    fi

    ## Do the thing, and echo the notification.  Errors echo to stdout
    if [[ $vf -gt 1 ]]; then
        yt-dlp --write-thumbnail --add-metadata $ytdsub --convert-subs=srt --sub-lang $subl --cookies $cookiez -f $vf "$ytdurl" -o '%(title)s.%(ext)s'
        yt-dlp -f $ytaf "$ytdurl" -o "$ytm4a"
        ffmpeg -i "${ytfn}.mp4" -i "$ytm4a" -c copy "${ytfn}_.mp4"
        rm -f "${ytfn}.mp4"
        rm -f "$ytm4a"
        convert "${ytfn}.webp" "${ytfn}.png"
        convert "${ytfn}.png" -resize 150x84^ -gravity center -extent 150x84 "${ytthumb}_150x84.png"
        ffmpeg -i "${ytfn}_.mp4" -i "${ytfn}.${subl}.srt" -c copy -c:s mov_text "${ytfn}__.mp4"
        rm -f "${ytfn}_.mp4"
        ffmpeg -i "${ytfn}__.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}.mp4"
        rm -f "${ytfn}__.mp4"
        mv "${ytfn}.png" "${ytfn}-poster.png"
        rm -f "${ytfn}.webp"
        rm -f "${ytfn}.${subl}.srt"
        rm -f "$(cat $ytviddir/${ytdf} | grep vtt | tail -n1 | sed 's/^.*: //')"
        rm -f $ytviddir/${ytdf}
        if [[ -f "${ytfn}.mp4" ]]; then
            notify-send -u normal -i "$ytviddir/${ytthumb}_150x84.png" "YT Download Complete" "$ytfn"
            sleep 1
            rm -f "${ytviddir}/${ytthumb}_150x84.png"
        else
            notify-send -u normal -i video "$(echo -e "YT Download Failed:\n$ytfn")"
        fi
    else
        echo -en "\n\nNo format specified.  This script works best with mp4."
    fi
else
    if [[ $vf -gt 1 ]]; then
        yt-dlp --write-thumbnail --add-metadata --cookies $cookiez -f $vf "$ytdurl" -o '%(title)s.%(ext)s'
        convert "${ytfn}.webp" "${ytfn}.png"
        convert "${ytfn}.png" -resize 150x84^ -gravity center -extent 150x84 "${ytthumb}_150x84.png"
        ffmpeg -i "${ytfn}.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}_.mp4"
        mv "${ytfn}_.mp4" "${ytfn}.mp4"
#        if [[ $vf -eq 299 || $vf -eq 137 ]]; then
            yt-dlp -f $ytaf "$ytdurl" -o "$ytm4a"
            ffmpeg -i "${ytfn}.mp4" -i "$ytm4a" -c copy "${ytfn}_.mp4"
            rm -f "${ytfn}.mp4"
            mv "${ytfn}_.mp4" "${ytfn}.mp4"
            rm -f "$ytm4a"
            mv "${ytfn}.png" "${ytfn}-poster.png"
#        fi
        if [[ -f "${ytfn}.mp4" ]]; then
            notify-send -u normal -i "$ytviddir/${ytthumb}_150x84.png" "YT Download Complete" "$ytfn"
            sleep 1
            rm -f "${ytviddir}/${ytthumb}_150x84.png"
        else
            notify-send -u normal -i video "$(echo -e "YT Download Failed:\n$ytfn")"
        fi
    else
        echo -en "\n\nNo format specified.  This script works best with mp4."
    fi
fi
