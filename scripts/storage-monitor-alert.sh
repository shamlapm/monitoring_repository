#!/bin/bash
THRESHOLD=10
ALERT_EMAIL="shamlapm18@gmail.com"
PARTITION="/"

USAGE=$(df -h "$PARTITION" | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
    MESSAGE="Warning: Partition '$PARTITION' is at ${USAGE}% capacity on $(hostname).\n\nTop space consumers:\n$(du -sh /* 2>/dev/null | sort -rh | head -n 5)"
    echo -e "$MESSAGE" | mail -s "ALERT: Low Disk Space on $(hostname) (${USAGE}%)" "$ALERT_EMAIL"
    logger -p local0.warn "Disk space alert: $PARTITION is at ${USAGE}%"
    echo "$(date): [ALERT] Disk space at ${USAGE}%" >> ../alert_logs.txt
fi
