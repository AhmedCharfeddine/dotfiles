#!/bin/bash

set -e  # Exit on any error

# 🔍 Check and install GNU Stow if needed
install_stow() {
  if ! command -v stow &>/dev/null; then
    echo "📦 Installing GNU Stow..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      sudo apt update && sudo apt install -y stow
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      brew install stow
    else
      echo "❌ Unsupported OS. Please install stow manually."
      exit 1
    fi
  else
    echo "✅ stow is already installed."
  fi
}

# ⛓️ Stow all configs
stow_configs() {
  echo "🔗 Stowing dotfiles..."
  CONFIGS=("zsh" "neovim")

  for config in "${CONFIGS[@]}"; do
    if [ -d "$config" ]; then
      echo "→ Stowing $config"
      stow "$config"
    else
      echo "⚠️  Skipping $config (not found)"
    fi
  done
}

# 🐚 Set Zsh as default shell
set_zsh_default() {
  if [ "$SHELL" != "$(which zsh)" ]; then
    echo "⚙️  Setting Zsh as default shell..."
    chsh -s "$(which zsh)"
    echo "✅ Zsh is now your default shell (restart terminal to apply)."
  else
    echo "✅ Zsh is already your default shell."
  fi
}

# 🧩 Run everything
install_stow
stow_configs
set_zsh_default

echo "🎉 All done!"
