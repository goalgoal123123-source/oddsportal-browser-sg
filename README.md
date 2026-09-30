# oddsportal-browser-sg

A real Chromium browser running in Singapore (Render, free tier), controlled
remotely via noVNC from any browser. OddsPortal shows the most bookmakers to
Singapore IPs (US IPs see very few), so browsing through this box shows the
full bookmaker list.

## Use

Open `https://<service>.onrender.com/vnc.html`, enter the VNC password
(`VNC_PASSWORD` env var). Chromium opens on oddsportal.com.

## Notes

- Render free tier sleeps after ~15 min without traffic; reloading the page
  wakes it (takes ~1 min, session restarts fresh).
- 512 MB RAM: one tab at a time works best.
