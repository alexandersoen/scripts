#!/usr/bin/env bash

# Configuration
URLS=(
  "https://mail.google.com"
  "https://calendar.google.com"
  "https://www.messenger.com"
  "https://webmail.kth.se"
  "https://chat.google.com"
)
MARKER="gmail"
COM_CLASS="WM_COMM_CHROME"

WID=$(xdotool search --classname "$COM_CLASS" | head -n 1)

if [ -z "$WID" ]; then
  google-chrome-stable --new-window "${URLS[@]}" &
  
  while [ -z "$WID" ]; do
    sleep 0.1
    # Using "gmail" / marker to find correct windows
    WID=$(xdotool search --name "$MARKER" | head -n 1)
  done

  xprop -id "$WID" -f WM_CLASS 8s -set WM_CLASS "$COM_CLASS"

  until xprop -id "$WID" WM_STATE 2>/dev/null | grep -q "window state: Normal"; do
    sleep 0.1
  done

  xdotool windowactivate "$WID"
  xdotool key "super+shift+5"
fi

xdotool key "super+5"
