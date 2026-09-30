#!/bin/bash
# Remote Chromium in Singapore, controlled via noVNC in the user's browser.
set -e

PORT="${PORT:-8080}"
VNC_PASS="${VNC_PASSWORD:-changeme}"

mkdir -p ~/.vnc
x11vnc -storepasswd "$VNC_PASS" ~/.vnc/passwd >/dev/null

export DISPLAY=:99
Xvfb :99 -screen 0 1366x768x24 &
sleep 1
openbox &
x11vnc -display :99 -forever -shared -rfbauth ~/.vnc/passwd -rfbport 5900 &
sleep 1

# Pre-open OddsPortal (Singapore view = most bookmakers)
chromium --display=:99 --no-sandbox --disable-dev-shm-usage --disable-gpu \
  --window-size=1366,768 --window-position=0,0 \
  --no-first-run --disable-features=Translate \
  "https://www.oddsportal.com/" \
  >/tmp/chromium.log 2>&1 &

exec websockify --web /usr/share/novnc/ "$PORT" localhost:5900
