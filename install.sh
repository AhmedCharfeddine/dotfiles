#!/bin/bash

set -e  # Exit on any error

# 🔍 Check and install GNU Stow if needed
install_stow() {
  if ! command -v stow &>/dev/null; then
    echo "📦 Installing GNU Stow..."
    # Install via common package managers
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
      if command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y stow
      elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm stow
      elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y stow
      elif command -v zypper >/dev/null 2>&1; then
        sudo zypper install -y stow
      else
        echo "❌ No supported Linux package manager found. Falling back to manual install..."
      fi
    elif [[ "$OSTYPE_DETECTED" == "darwin" ]]; then
      if command -v brew >/dev/null 2>&1; then
        brew install stow
      else
        echo "❌ Homebrew not found. Install Homebrew or install stow manually."
        exit 1
      fi
    else
      echo "❌ Unsupported OS: $OSTYPE_DETECTED"
      exit 1
    fi

    # Final check
    if command -v stow >/dev/null 2>&1; then
      echo "✅ stow installed successfully"
    else
      echo "❌ stow installation failed. Please install it manually."
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
