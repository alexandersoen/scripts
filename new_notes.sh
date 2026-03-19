#!/usr/bin/env bash

NOTE_TEMPLATE_DIR=$HOME/templates/notes

if [ "$#" -ne 1 ]; then
  echo "Illegal number of parameters"
  exit
fi

# Clone and reset
git clone "$NOTE_TEMPLATE_DIR" "$1"
rm -rf "$1/.git"
cd "$1" || exit
git init
