#!/bin/bash

# Nagios plugin to check connected clients for a minecraft instance

. /usr/lib/nagios/plugins/utils.sh

WARN=15
CRIT=19

while getopts "c:w:h" ARG; do
    case $ARG in
        w) WARN=$OPTARG;;
        c) CRIT=$OPTARG;;
        h) echo "Usage: $0 -w <warning threshold> -c <critical threshold>"; exit;;
    esac
done

# TODO: Modify to allow for alternate ports!
# i.e. $PORT=25565
CLIENTS=`netstat -anlt | grep ':25565' | grep ESTABLISHED | wc -l`;

# echo "${CLIENTS} connected on port ${PORT}"
echo "${CLIENTS} clients connected on port 25565"

if [ $CLIENTS -gt $CRIT ]; then
    exit $STATE_CRITICAL;
elif [ $CLIENTS -gt $WARN ]; then
    exit $STATE_WARNING;
else
    exit $STATE_OK;
fi
