#!/bin/bash
THRESHOLD=80
ALERT_EMAIL="shamlapm18@gmail.com"
CURRENT_CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

if (( ${CURRENT_CPU%.*} >= $THRESHOLD )); then
    MESSAGE="Warning: CPU Usage is high at ${CURRENT_CPU}% on $(hostname)."
    echo -e "$MESSAGE" | mail -s "ALERT: High CPU on $(hostname)" "$ALERT_EMAIL"
    echo "$(date): [ALERT] CPU usage at ${CURRENT_CPU}%" >> ../alert_logs.txt
fi
