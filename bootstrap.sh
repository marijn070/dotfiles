#!/usr/bin/env bash
set -euo pipefail

CHEZMOI_CONFIG="$HOME/.config/chezmoi/chezmoi.toml"

# Ensure config directory exists
mkdir -p "$(dirname "$CHEZMOI_CONFIG")"

# Ensure [data] section exists and role is set
if ! grep -q '^\[data\]' "$CHEZMOI_CONFIG" 2>/dev/null; then
  echo "[data]" >> "$CHEZMOI_CONFIG"
fi

# Set default role if missing or empty
if ! grep -q '^role\s*=' "$CHEZMOI_CONFIG" 2>/dev/null; then
  echo 'role = "default"' >> "$CHEZMOI_CONFIG"
fi


# Run chezmoi init and apply
# If already initialized, this is safe to run again
chezmoi init marijn070 --apply
