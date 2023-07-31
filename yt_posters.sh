#!/bin/bash

### This script requires the following software
### yt-dlp: https://github.com/yt-dlp/yt-dlp#installation
### imagemagick
### libnotify4 (arch: libnotify)

## This script downloads the thumbnail of the specified YouTube video
## and saves it as thumbnail-poster.png for Jellyfin

## The variables
ytdurl="$1"
ytfn="$(yt-dlp $ytdurl -o "%(title)s" --get-filename)"
ytviddir="$HOME/Videos/YouTube"
cookiez="$HOME/cookies.txt"
ytdf="${RANDOM}.txt"

cd $ytviddir

## Display video title
echo -e "\n\nFetching poster image for: ${ytfn}\n\n"
sleep 1

yt-dlp "$ytdurl" --skip-download --write-thumbnail -o '%(title)s.%(ext)s'
convert "${ytfn}.webp" "${ytfn}-poster.png"
rm -f "${ytfn}.webp"

echo -en "\nFetched "${ytfn}-poster.png"\n"
