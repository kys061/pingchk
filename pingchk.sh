#!/bin/bash

dstaddresses=($(cat address.txt  |sed /#/d |awk '{print $2}'))
srcaddress='172.16.0.1'
# Bash Colors
red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m'

clear
while :
do
        for ((i=0; i<${#dstaddresses[@]}; i++));
#          for address in ${#dstaddresses[@]} #$@ #$addresses
        do
                ping -c1 -W1 -I $srcaddress ${dstaddresses[$i]} >> /dev/null
                if [ $? -eq 1 ]
                then
                        echo -e "$srcaddress \033[s\033[K\033[u --> ${dstaddresses[$i]}\t${red}  ping is fail${NC}"
                else
                        echo -e "$srcaddress \033[s\033[K\033[u --> ${dstaddresses[$i]}\t${green}  ping is ok${NC}"
                fi
        done
        echo -en "Press [CTRL+C] to stop..\033[K"
        sleep 1
        echo -en "\n\033[K"
        echo -en "\033[0;0H"
done

