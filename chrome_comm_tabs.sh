#!/usr/bin/env bash

# Configuration
URLS=(
  "https://mail.google.com"
  "https://calendar.google.com"
  "https://web.whatsapp.com"
  "https://www.messenger.com"
  "https://webmail.kth.se"
  "https://chat.google.com"
  "https://mattermost.cmlab.dev"
)
MARKER="gmail"
COM_INSTANCE="wm_comm_chrome"

WID=$(xdotool search --classname "$COM_INSTANCE" | head -n 1)

if [ -z "$WID" ]; then
  google-chrome-stable --new-window "${URLS[@]}" &

  while [ -z "$WID" ]; do
    sleep 0.1
    # Using "gmail" / marker to find correct windows
    WID=$(xdotool search --name "$MARKER" | head -n 1)
  done
fi

# Chrome's window has already been managed by the time its instance is changed.
# Reassert it on every invocation so DWM can apply (or repair) the tag rule.
xdotool set_window --classname "$COM_INSTANCE" "$WID" key "super+5"
