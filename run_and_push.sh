#!/bin/bash
cd "$(dirname "$0")"

./scripts/cpu-monitor-alert.sh
./scripts/mem-monitor-alert.sh
./scripts/storage-monitor-alert.sh

if [[ -n $(git status --porcelain alert_logs.txt) ]]; then
    echo "Alert triggered! Syncing updates to GitHub..."
    git add alert_logs.txt
    git commit -m "Automated Alert Sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
else
    echo "Metrics normal. GitHub is clear."
fi
