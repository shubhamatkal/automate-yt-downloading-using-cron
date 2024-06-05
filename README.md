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
