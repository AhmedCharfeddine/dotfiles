#!/bin/bash

# Skip if already installed
if command -v lazygit >/dev/null 2>&1; then
  echo "Lazygit already installed."
  exit 0
fi

echo "Installing LazyGit..."

# Get latest version
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
VERSION_NO_V="${LAZYGIT_VERSION#v}"

# Detect platform and arch
UNAME_OS=$(uname -s)
UNAME_ARCH=$(uname -m)

case "$UNAME_OS" in
  Linux)  OS="Linux" ;;
  Darwin) OS="Darwin" ;;
  *) echo "Unsupported OS: $UNAME_OS"; exit 1 ;;
esac

case "$UNAME_ARCH" in
  x86_64) ARCH="x86_64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $UNAME_ARCH"; exit 1 ;;
esac

# Build filename
FILENAME="lazygit_${VERSION_NO_V}_${OS}_${ARCH}.tar.gz"
URL="https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/${FILENAME}"

# Download and extract
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR" || exit 1

echo "Downloading $FILENAME..."
if curl -LO "$URL"; then
  tar -xzf "$FILENAME"
  mkdir -p "$HOME/.local/bin"
  mv lazygit "$HOME/.local/bin/"
  chmod +x "$HOME/.local/bin/lazygit"
  echo "✅ Installed lazygit to ~/.local/bin"
else
  echo "❌ Failed to download $FILENAME"
  exit 1
fi
