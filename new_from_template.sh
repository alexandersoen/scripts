#!/usr/bin/env bash
set -euo pipefail

DMENU="dmenu -p"

# Template sources
NOTE_TEMPLATE_DIR="$HOME/templates/notes"
SLIDE_TEMPLATE_DIR="$HOME/templates/slides"

# Destination parents
NOTE_DIR="$HOME/notes"
SLIDE_DIR="$HOME/slides"

# Choose template type
template_type=$(
  # printf "%s\n" "note" "slide" | eval "$DMENU 'Template'"
  printf "%s\n" "note" | eval "$DMENU 'Template'"
)

[ -z "${template_type:-}" ] && exit 0

case "$template_type" in
note)
  TEMPLATE_SRC="$NOTE_TEMPLATE_DIR"
  DEST_PARENT="$NOTE_DIR"
  ;;
slide)
  TEMPLATE_SRC="$SLIDE_TEMPLATE_DIR"
  DEST_PARENT="$SLIDE_DIR"
  ;;
*)
  notify-send "Template script" "Invalid template type selected"
  exit 1
  ;;
esac

# Ask for folder/project name
folder_name=$(
  printf "" | eval "$DMENU 'Folder name'"
)

[ -z "${folder_name:-}" ] && exit 0

DEST_PATH="$DEST_PARENT/$folder_name"

if [ -e "$DEST_PATH" ]; then
  notify-send "Template script" "Destination already exists: $DEST_PATH"
  exit 1
fi

mkdir -p "$DEST_PARENT"

# Clone, strip history, re-init
git clone "$TEMPLATE_SRC" "$DEST_PATH"
rm -rf "$DEST_PATH/.git"
cd "$DEST_PATH"
git init

notify-send "Template script" "Created $template_type at $DEST_PATH"
