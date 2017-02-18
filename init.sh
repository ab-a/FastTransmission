#!/bin/sh 

# Vars
USER-PASSWORD=password
WEB-PASSWORD= password

## Installation of Transmission Daemon and vsftpd
apt-get update && apt-get install transmission-daemon vsftpd -y

## Manage Transmission user
adduser td --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "td:$USER-PASSWORD" | chpasswd
usermod -a -G debian-transmission td
mkdir /home/td/downloads
chmod 755 -R /home/td

## Setting up transmission daemon
service transmission-daemon stop
sleep 1
echo '{
    "alt-speed-down": 50,
    "alt-speed-enabled": false,
    "alt-speed-time-begin": 540,
    "alt-speed-time-day": 127,
    "alt-speed-time-enabled": false,
    "alt-speed-time-end": 1020,
    "alt-speed-up": 0,
    "bind-address-ipv4": "0.0.0.0",
    "bind-address-ipv6": "::",
    "blocklist-enabled": false,
    "blocklist-url": "http://www.example.com/blocklist",
    "cache-size-mb": 4,
    "dht-enabled": false,
    "download-dir": "/home/td/downloads",
    "download-limit": 100,
    "download-limit-enabled": 1,
    "download-queue-enabled": true,
    "download-queue-size": 5,
    "encryption": 1,
    "idle-seeding-limit": 0,
    "idle-seeding-limit-enabled": true,
    "incomplete-dir": "/home/td/downloads",
    "incomplete-dir-enabled": false,
    "lpd-enabled": false,
    "max-peers-global": 200,
    "message-level": 1,
    "peer-congestion-algorithm": "",
    "peer-id-ttl-hours": 6,
    "peer-limit-global": 200,
    "peer-limit-per-torrent": 50,
    "peer-port": 51413,
    "peer-port-random-high": 65535,
    "peer-port-random-low": 49152,
    "peer-port-random-on-start": false,
    "peer-socket-tos": "default",
    "pex-enabled": false,
    "port-forwarding-enabled": false,
    "preallocation": 1,
    "prefetch-enabled": 1,
    "queue-stalled-enabled": true,
    "queue-stalled-minutes": 30,
    "ratio-limit": 0,
    "ratio-limit-enabled": true,
    "rename-partial-files": true,
    "rpc-authentication-required": true,
    "rpc-bind-address": "0.0.0.0",
    "rpc-enabled": true,
    "rpc-password": "$WEB-PASSWORD",
    "rpc-port": 9091,
    "rpc-url": "/transmission/",
    "rpc-username": "transmission",
    "rpc-whitelist": "127.0.0.1",
    "rpc-whitelist-enabled": false,
    "scrape-paused-torrents-enabled": true,
    "script-torrent-done-enabled": false,
    "script-torrent-done-filename": "",
    "seed-queue-enabled": false,
    "seed-queue-size": 10,
    "speed-limit-down": 10000,
    "speed-limit-down-enabled": false,
    "speed-limit-up": 0,
    "speed-limit-up-enabled": false,
    "start-added-torrents": true,
    "trash-original-torrent-files": false,
    "umask": 18,
    "upload-limit": 0,
    "upload-limit-enabled": 0,
    "upload-slots-per-torrent": 0,
    "utp-enabled": true
}' > /etc/transmission-daemon/settings.json
sleep 1
service transmission-daemon start
