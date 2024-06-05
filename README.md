# YouTube Playlist Downloader

This project provides a script to download YouTube playlists during specific hours (12 AM to 6 AM) using unlimited data plans of VI.

## Requirements

Ensure the following packages are installed on your system:

- `yt-dlp`: To download YouTube videos.
- `jq`: For JSON processing.
- `nmcli`: To manage WiFi connections.
- `cron`

### Installation on Arch Linux

```sh
sudo pacman -S yt-dlp jq nmcli cron
```

## Project Setup

### Clone the repository:

```sh
git clone https://github.com/yourusername/yt-playlist-downloader.git
cd yt-playlist-downloader
```

## Configure JSON File:
### Create a yt-playlist-links.json file with your YouTube playlist URLs:

```sh
[
    "https://www.youtube.com/playlist?list=YOUR_PLAYLIST_ID",
    "https://www.youtube.com/playlist?list=ANOTHER_PLAYLIST_ID"
]
```

## Crontab Setup
### To schedule the download script and the kill script, add the following lines to your crontab:

Edit your crontab
```sh
crontab -e
```
Add the following cron jobs
```sh
5 0 * * * /root/cronjobs/yt-playlist-downloader/cron_job_script.sh
50 5 * * * /root/cronjobs/yt-playlist-downloader/playlist-script-name-here.sh
```
This setup will run the download script at 12:05 AM every day and attempt to kill the download process at 5:50 AM every day.



