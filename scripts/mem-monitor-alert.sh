#!/bin/bash
THRESHOLD=85
ALERT_EMAIL="shamlapm18@gmail.com"
CURRENT_MEM=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

if (( ${CURRENT_MEM%.*} >= $THRESHOLD )); then
    MESSAGE="Warning: Memory Usage is high at ${CURRENT_MEM}% on $(hostname)."
    echo -e "$MESSAGE" | mail -s "ALERT: High Memory on $(hostname)" "$ALERT_EMAIL"
    echo "$(date): [ALERT] Memory usage at ${CURRENT_MEM}%" >> ../alert_logs.txt
fi
