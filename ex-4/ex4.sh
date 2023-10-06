#!/bin/bash
ACCESS_LOG=$(cat access.log)

# Get top 5 ips visiting the
TOP5_IP=$(echo "${ACCESS_LOG}" |
        grep -oE "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | #Regexp for getting only the IP.
        sort  |
        uniq -c |
        sed 's/^[[:space:]]*//g' |  #Delete the space from the beggining
        sort -h  --reverse |        #Sort with the human option.
        head -n 5)                  #Only the first 5 lines
#Count the different http code status by http method
TOP_HTTP_METHOD_BY_CODE=$(echo "${ACCESS_LOG}" |
        grep -o '".*' |     #Regexp for getting the match from when starts the " charactater
        cut -d " " -f1,4 |  #Used the delimiter space as a separator in order to get the fields 1(http verb) and 4 (http code)
        grep "[0-9]$" |     #We use a regexp to be sure that the 4 field from the last command is a number (http code)
        tr -d '"' |         #Delete the " character from the beggining of the file
        sort |
        uniq -c |
        sed 's/^[[:space:]]*//g' |   #Delete the spaces from the beggining.
        sort --sort=h -r)

echo "---TOP 5 IP---"
echo "$TOP5_IP"
echo "---HTTP METHODS---"
echo "${TOP_HTTP_METHOD_BY_CODE}"
