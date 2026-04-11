#!/usr/bin/env bash
set -euo pipefail

DMENU="dmenu -p"

notify_error() {
  notify-send -u critical "Display Setup" "$1"
}

if ! setup=$(autorandr --list | eval "$DMENU 'Display Setup'"); then
  notify_error "Failed to list autorandr profiles"
  exit 1
fi

# Select
if err=$(autorandr -l "$setup" 2>&1 > /dev/null); then
  if [[ "$err" == *"Config already loaded"* ]]; then
    notify-send "Display Setup" "$setup already loaded"
    exit 0
  fi
  notify-send "Display Setup" "Loaded $setup"

else
  notify_error "Failed to load $setup"
  exit 1
fi
