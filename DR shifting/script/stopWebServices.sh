#!/usr/bin/env bash

mainPath='/home/nickghule/data/cris/DR shifting'
source "$mainPath"/resource/globals.sh



if [ "$1" = "CR" ]
then 
    echo "CR"
    web1="10.0.100.129"
    web2="10.0.100.129"
elif [ "$1" = "WR" ]
then
    echo "WR"
elif [ "$1" = "WC" ]
then
    echo "WC"
elif [ "$1" = "KR" ]
then
    echo "KR"
else
    echo "Invalid Zone Code"
    exit 1
fi

# Stop web Instance 1
echo -en "Stopping web instance 1 :"
ssh utswebsrv@"$web1" "sudo systemctl start tomcat"
loadingAnimation 4
if ssh utswebsrv@"$web1" "sudo systemctl status tomcat"| grep -q "Active: inactive (dead)"
then
    echo -e " $greenCheck"
else
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Error in stopping web instance 1. Please check manually."
    echo -e "Press enter to continue"
    read -r
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
fi

# Stop web Instance 2
echo -en "Stopping web instance 2 :"
ssh utswebsrv@"$web2" "sudo systemctl stop tomcat"
loadingAnimation 4
if ssh utswebsrv@"$web2" "sudo systemctl status tomcat"| grep -q "Active: inactive (dead)"
then
    echo -e " $greenCheck"
else
    echo -e " $redCross"
    printf "\e[33m%s\e[0m\n" "Error in stopping web instance 2. Please check manually."
    echo -en "Press enter to continue"
    read -r
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
    printf "\033[1A\033[0K"
fi