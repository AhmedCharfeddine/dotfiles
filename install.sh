#!/bin/bash
# Dotfiles Installer for Fedora

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/RobotoMono.zip"

install_core_deps() {
    echo "Installing core dependencies..."
    sudo dnf install -y git make git stow zsh fzf zoxide fd-find ripgrep curl tar unzip
}

install_neovim() {
    echo "Installing Neovim..."
    TMP_DIR=$(mktemp -d)
    curl -LO --output-dir "$TMP_DIR" https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf "$TMP_DIR/nvim-linux-x86_64.tar.gz"
    rm -rf "$TMP_DIR"
    echo "Neovim installed to /opt/nvim-linux-x86_64"
}

install_lazygit() {
    echo "Installing LazyGit from COPR..."
    sudo dnf copr enable atim/lazygit -y
    sudo dnf install -y lazygit
}

install_tmux() {
    echo "Installing tmux..."
    sudo dnf install -y tmux
}

install_nerd_font() {
    echo "Installing RobotoMono Nerd Font..."
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    TMP_DIR=$(mktemp -d)
    curl -L "$FONT_URL" -o "$TMP_DIR/font.zip"
    unzip -q "$TMP_DIR/font.zip" -d "$TMP_DIR"
    cp "$TMP_DIR"/*.ttf "$FONT_DIR/"
    rm -rf "$TMP_DIR"
    fc-cache -f
    echo "Font installed to $FONT_DIR"
}

install_node() {
    echo "Installing Node.js via nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install --lts
}

stow_package() {
    echo "Stowing $1..."
    cd "$DOTFILES_DIR"
    stow "$1"
}

stow_menu() {
    while true; do
        echo ""
        echo "Select package to stow:"
        echo "  1) zsh"
        echo "  2) neovim"
        echo "  3) kitty"
        echo "  4) tmux"
        echo "  5) All"
        echo "  0) Back"
        read -r -p "> " choice
        case $choice in
            1) stow_package zsh ;;
            2) stow_package neovim ;;
            3) stow_package kitty ;;
            4) stow_package tmux ;;
            5) stow_package zsh; stow_package neovim; stow_package kitty; stow_package tmux ;;
            0) return ;;
        esac
    done
}

set_zsh_default() {
    echo "Setting Zsh as default shell..."
    chsh -s "$(which zsh)"
}

install_everything() {
    install_core_deps
    install_neovim
    install_lazygit
    install_tmux
    install_nerd_font
    stow_package zsh
    stow_package neovim
    stow_package kitty
    stow_package tmux
    set_zsh_default
    echo "Done! Restart your terminal."
}

main_menu() {
    while true; do
        echo ""
        echo "Dotfiles Installer (Fedora)"
        echo "  1) Install everything"
        echo "  2) Install core deps (git, stow, zsh, fzf, zoxide...)"
        echo "  3) Install Neovim"
        echo "  4) Install LazyGit"
        echo "  5) Install tmux"
        echo "  6) Install RobotoMono Nerd Font"
        echo "  7) Install Node.js (nvm)"
        echo "  8) Stow configs..."
        echo "  9) Set Zsh as default"
        echo "  0) Exit"
        read -r -p "> " choice
        case $choice in
            1) install_everything ;;
            2) install_core_deps ;;
            3) install_neovim ;;
            4) install_lazygit ;;
            5) install_tmux ;;
            6) install_nerd_font ;;
            7) install_node ;;
            8) stow_menu ;;
            9) set_zsh_default ;;
            0) exit 0 ;;
        esac
    done
}

main_menu
