#!/usr/bin/env bash
dmenu_path | dmenu "$@" | xargs urxvt -e &
