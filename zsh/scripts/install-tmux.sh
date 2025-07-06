#!/bin/bash

set -e  # Exit on any error

echo "📦 Installing tmux..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt install -y tmux
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy tmux --noconfirm
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y tmux
  else
    echo "❌ Unsupported Linux package manager. Please install tmux manually."
    exit 1
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
  if command -v brew >/dev/null 2>&1; then
    brew install tmux
  else
    echo "❌ Homebrew not found. Please install Homebrew first: https://brew.sh"
    exit 1
  fi

else
  echo "❌ Unsupported OS: $OSTYPE"
  exit 1
fi

echo "✅ tmux installed successfully."
