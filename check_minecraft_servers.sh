#!/bin/bash

# Nagios plugin to check for listening minecraft servers

. /usr/lib/nagios/plugins/utils.sh

# Will this work? 0 is supposed to be bad...also right now, we're just
# checking for one individual server.
WARN=0
CRIT=0

while getopts "c:w:h" ARG; do
    case $ARG in
        w) WARN=$OPTARG;;
        c) CRIT=$OPTARG;;
        h) echo "Usage: $0 -w <warning threshold> -c <critical threshold>"; exit;;
    esac
done

#SERVERS=`netstat -alt | grep ':25565' | grep LISTEN | wc -l`;
SERVERS=`pgrep -f 'jar minecraft_server' | wc -l`

echo "${SERVERS} Minecraft servers listening"

if [ $SERVERS -eq $CRIT ]; then
    exit $STATE_CRITICAL;
elif [ $SERVERS -lt $WARN ]; then
    exit $STATE_WARNING;
else
    exit $STATE_OK;
fi
