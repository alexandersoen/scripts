#!/bin/bash

DIRS=(
  "$HOME/Documents/papers"
  "$HOME/Downloads"
  "$HOME/Zotero/storage"
)

PREVIEW_STR='cd "$HOME" && pdftotext -f 1 -l 5 {} - 2>/dev/null'

if [[ $# -eq 1 ]]; then
  selected=$1
else
  # Tried using find (and fzf), wayyy slower.
  selected=$(fd -e pdf . "${DIRS[@]}" --type=file --full-path \
    | sed "s|^$HOME/||" \
    | sk --margin 10% --preview="$PREVIEW_STR"
  )

  [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

open "$selected"
