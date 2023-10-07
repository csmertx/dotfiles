#!/bin/bash

cd "/home/chris/Games/psx"
cdrdao read-cd --read-raw --datafile "$1.bin" --device /dev/sr0 --driver generic-mmc-raw "$1.cue"
