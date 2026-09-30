#!/bin/bash
# Remote Chromium in Singapore, controlled via noVNC in the user's browser.
# Xvnc = VNC server with built-in X server (no x11vnc attach needed).
set -e

PORT="${PORT:-8080}"
VNC_PASS="${VNC_PASSWORD:-changeme}"

mkdir -p ~/.vnc
# x11vnc's -storepasswd reliably writes the VNC passwd file format on Debian
x11vnc -storepasswd "$VNC_PASS" ~/.vnc/passwd >/dev/null
chmod 600 ~/.vnc/passwd
ls -l ~/.vnc/passwd

export DISPLAY=:99
Xvnc :99 -geometry 1366x768 -depth 24 -rfbauth ~/.vnc/passwd &
sleep 2
openbox &
sleep 1

# Pre-open OddsPortal (Singapore view = most bookmakers)
chromium --display=:99 --no-sandbox --disable-dev-shm-usage --disable-gpu \
  --window-size=1366,768 --window-position=0,0 \
  --no-first-run --disable-features=Translate \
  "https://www.oddsportal.com/" \
  >/tmp/chromium.log 2>&1 &

exec websockify --web /usr/share/novnc/ "$PORT" 127.0.0.1:5900
