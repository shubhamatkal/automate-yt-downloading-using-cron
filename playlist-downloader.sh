#!/bin/bash

# Directories
DOWNLOADS_DIR="$HOME/Downloads/YT-Playlists-cron"
ERROR_FILE="$HOME/cronjobs/yt-playlist-downloader/yt-playlist-errors-log.txt"
# Create necessary directories if they don't exist
mkdir -p "$DOWNLOADS_DIR"

# Function to download playlist
download_playlist() {
    PLAYLIST_URL=$1
    PLAYLIST_NAME=$(yt-dlp --get-filename -o "%(playlist_title)s" "$PLAYLIST_URL" 2>/dev/null)
    PLAYLIST_DIR="$DOWNLOADS_DIR/$PLAYLIST_NAME"

    # Create playlist directory
    mkdir -p "$PLAYLIST_DIR"
    ERROR_LOG="$PLAYLIST_DIR/errorlog.txt"
    # Create error log file if it doesn't exist
    touch "$ERROR_LOG"
    # Download videos in 720p or lower if not available, log errors
    yt-dlp -o "$PLAYLIST_DIR/%(title)s.%(ext)s" -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --ignore-errors --download-archive "$PLAYLIST_DIR/downloaded.txt" "$PLAYLIST_URL" 2>>"$ERROR_LOG"
    # Check if yt-dlp was successful
    if [ $? -eq 0 ]; then
        # Remove the processed URL from the JSON file
        jq --arg url "$PLAYLIST_URL" 'del(.[] | select(. == $url))' "$JSON_FILE" > "$JSON_FILE.tmp" && mv "$JSON_FILE.tmp" "$JSON_FILE"
    fi
}

# Read JSON file
JSON_FILE="$HOME/cronjobs/yt-playlist-downloader/yt-playlist-links.json"

# Check if file exists and is not empty
if [[ -s "$JSON_FILE" ]]; then
    PLAYLIST_URLS=$(jq -r '.[]' "$JSON_FILE")

    # Iterate over playlist URLs and download
    for URL in $PLAYLIST_URLS; do
        download_playlist "$URL"
    done
else
    echo "$(date): JSON file is empty or does not exist." >>"$ERROR_FILE"
fi

