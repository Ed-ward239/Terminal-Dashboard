#!/bin/bash

# Define the name of the tmux session
SESSION=ghostty_dash

# Kill any existing session with the same name (suppress error if not found)
tmux kill-session -t $SESSION 2>/dev/null

# Start a new detached tmux session with one window named 'dash'
tmux new-session -d -s $SESSION -n dash
tmux list-panes -t $SESSION -F "#{pane_index} #{pane_title} #{pane_left} #{pane_top} #{pane_width}x#{pane_height}"
# ───────────── Top Row ─────────────
# Pane 0: FastFetch (default)
# Pane 1: split right of 0 (TTY-Clock)
tmux split-window -h -t $SESSION:0.0
# Pane 2: split right of 1 (Ticker)
tmux split-window -h -t $SESSION:0.1

# ───────────── Middle Row ─────────────
# Pane 3: split below Pane 0 (Btop)
tmux split-window -v -t $SESSION:0.0
# Pane 4: split below Pane 1 (Weather)
tmux split-window -v -t $SESSION:0.1
# Pane 5: split below Pane 2 (Yazi)
tmux split-window -v -t $SESSION:0.2

# ───────────── Bottom Row ─────────────
# Pane 6: split below Pane 4 (RSS)
tmux split-window -v -t $SESSION:0.4
# Pane 7: split right of Pane 6 (Notes)
tmux split-window -h -t $SESSION:0.6

# ───────────── Optional: Run Commands in Each Pane ─────────────
tmux send-keys -t $SESSION:0.0 'fastfetch' C-m
tmux send-keys -t $SESSION:0.1 'tty-clock -c -C 5 -s -B' C-m
tmux send-keys -t $SESSION:0.2 'ticker --watchlist AAPL,NVDA,TSLA,MSFT,GOOG,SPY,TSLL,AMDL --show-summary --show-tags --show-fundamentals --show-separator --sort alpha' C-m
tmux send-keys -t $SESSION:0.3 'btop' C-m
tmux send-keys -t $SESSION:0.4 'ccalcurse' C-m
tmux send-keys -t $SESSION:0.5 'yazi ~/Documents' C-m
tmux send-keys -t $SESSION:0.6 'newsboat' C-m
tmux send-keys -t $SESSION:0.7 'nvim ~/notes.txt' C-m

# Tidy up: apply a tiled layout to normalize pane arrangement
tmux select-layout -t $SESSION tiled

# Focus back to the top-left pane before attaching
tmux select-pane -t $SESSION:0.0

# Attach to session
tmux attach-session -t $SESSION
