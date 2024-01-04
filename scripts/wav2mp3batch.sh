#!/bin/bash

# ~/.bashrc
# alias music="/home/chris/.scripts/wav2mp3batch.sh"

cd ~/Videos
cdparanoia -B

for i in *.wav
do
    ffmpeg -i "$i" -b:a 320k "$(echo $i | sed -s 's/.cdda.wav/.mp3/g')"
    echo "$i"
done
