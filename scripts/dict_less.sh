#!/bin/bash
## Requires: dictd + additonal dictionary databases as needed

dltxt="/dev/shm/dict_less.txt"

dict $1 > $dltxt

less < $dltxt
rm /dev/shm/dict_less.txt
