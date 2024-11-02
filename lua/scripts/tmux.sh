#!/bin/bash

NAME="$(date +%s)"

tmux new-window -n "$NAME"
tmux send-keys -t "$NAME" "vim ." C-m

