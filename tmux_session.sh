#!/bin/bash

# Taken from https://github.com/SylvanFranklin/.config/blob/main/scripts/tmux-session-dispensary.sh.

DIRS=(
  "$HOME/Documents/code"
  "$HOME/Documents/papers"
)

if [[ $# -eq 1 ]]; then
  selected=$1
else
  # Tried using find (and fzf), wayyy slower.
  selected=$(fd . "${DIRS[@]}" --type=dir --max-depth=1 --full-path --base-directory $HOME \
    | sed "s|^$HOME/||" \
    | sk --margin 10% --preview="tree $HOME/{} -L 2"
  )

  [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
