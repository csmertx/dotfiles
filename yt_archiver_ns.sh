

### This script requires the following software
### yt-dlp: https://github.com/yt-dlp/yt-dlp#installation
### imagemagick
### libnotify4 (arch: libnotify)
### ffmpeg (merges thumbnail, subtitles, and m4a audio to final video file--up to 1080p 60fps)
### Jellyfin for local network streaming

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
ytm4a="${RANDOM}.m4a"
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
    yt-dlp -f 140 "$ytdurl" -o "$ytm4a"
    ffmpeg -i "${ytfn}.mp4" -i "$ytm4a" -c copy "${ytfn}_.mp4"
    rm -f "${ytfn}.mp4"
    rm -f "$ytm4a"
    ffmpeg -i "${ytfn}_.mp4" -i "${ytfn}.png" -map 1 -map 0 -c copy -disposition:0 attached_pic "${ytfn}.mp4"
    if [[ -f "${ytfn}.mp4" ]]; then
        notify-send -u normal -i video "$(echo -e "YT Download Complete:\n$ytfn")"
    else
        notify-send -u normal -i video "$(echo -e "YT Download Failed:\n$ytfn")"
    fi
    mv "${ytfn}.png" "${ytfn}-poster.png"
    rm -f "${ytfn}.webp"
    rm -f "${ytfn}_.mp4"
else
    echo -en "\n\nNo format specified.  This script works best with mp4."
fi
