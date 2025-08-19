export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# ― AUTO DASHBOARD IN GHOSTTY ―
if [[ $TERM_PROGRAM == "ghostty" ]] && [[ -z "$TMUX" ]]; then
  echo "🖥️ Launching dashboard..."
  sleep 2
  ~/dashboard.sh
  exit 0
fi
