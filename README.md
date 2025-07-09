## Dotfiles


### Requirements
Packages needed to run/see the configs
```
git
stow
zsh
fzf 0.48.0 or later
nvim
zoxide
neovim
emacs (for tmux keybinds)
```
> For Neovim, it's better to get the latest pre-built binary from [the official repo](https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2).
#### Optional
```
npm and node 20 or newer (for Python support inside Neovim + copilot)
luarocks for neorg (notes inside neovim)
fd (fd-find on Ubuntu. Create a symlink via ln -s $(which fdfind) ~/.local/bin/fd)
Any nerd font
```

### Installation
Clone the repository
```
git clone git@github.com:AhmedCharfeddine/dotfiles.git
```
Edit `install.sh` with your OS' package manager (apt, dnf, or whatever) and the things you want to stow (zsh, nvim, etc.) and run it.
