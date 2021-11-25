#!/bin/bash

## The 1995 MST3K Turkey Day Marathon from Archive.org
wget https://archive.org/download/MST3K1/MST3K%201.mp4
notify-send -u critical -i video "$(echo -e "MST3K Turkey Day 1995 1/3\n1. The Crawling Hand, 2. Manos: The Hand of Fate, 3. Mitchell [Pt. 1]")"
sleep 3
wget https://archive.org/download/MST3K2/MST3K%202.mp4
notify-send -u critical -i video "$(echo -e "MST3K Turkey Day 1995 2/3\n1. Mitchel [Pt. 2], 2. Outlaw, 3. The Skydivers")"
sleep 3
wget https://archive.org/download/MST3K3_201711/MST3K%203.mp4
notify-send -u critical -i video "$(echo -e "MST3K Turkey Day 1995 3/3\n1. The Starfighters, 2. Poople Parade of Values, 3. Night of the Blood Beast")"
