#!/usr/bin/env bash

# check if my sql is running
redCross="\e[31m\xE2\x9C\x98\e[0m"
greenCheck="\e[32m\xE2\x9C\x94\e[0m"
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