#!/usr/bin/env bash

mainPath='/home/nickghule/data/cris/DR shifting'
source "$mainPath"/resource/globals.sh


# check if my sql is running
echo -en "Stopping Sync (ML 17 Instance 2) :"
echo -e " $redCross"
printf "\e[33m%s\e[0m\n" "Ml17 database is still running. Please stop manually."
echo -e "Press enter to continue"
read -r
# rewrite last two lines and last 3 characters
printf "\033[2A"
printf "\033[0K"
printf "\033[1A"
printf "\033[0K"