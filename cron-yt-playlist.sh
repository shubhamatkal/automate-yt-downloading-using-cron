#!/bin/bash

# Directory where the script and JSON file are located
SCRIPT_DIR="$HOME/cronjobs/yt-playlist-downloader"
CRON_ERROR_LOG="$SCRIPT_DIR/yt-playlist-errors-log.txt"

# Change to the script directory
cd "$SCRIPT_DIR"

# Function to attempt WiFi connection
attempt_wifi_connection() {
    local tries=3
    local interval=5
    local connected=false

    for (( i=1; i<=tries; i++ )); do
        nmcli connect dev wifi wifiname password ********
        sleep $interval
        if nmcli -t -f WIFI g | grep -q 'enabled'; then
            connected=true
            break
        fi
    done

    echo $connected
}

# Check for WiFi connection
if ! nmcli -t -f WIFI g | grep -q 'enabled'; then
    if [[ $(attempt_wifi_connection) == "false" ]]; then
        echo "$(date): WiFi is not connected." >>"$CRON_ERROR_LOG"
        exit 1
    fi
fi

# Prevent sleep mode
#systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# Execute download script
bash "$SCRIPT_DIR/playlist-downloader.sh" 2>>"$CRON_ERROR_LOG"

# Re-enable sleep mode
#systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target

