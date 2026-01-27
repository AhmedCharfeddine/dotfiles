# Dotfiles

Personal dotfiles for Fedora Linux

## Quick Start

```bash
git clone git@github.com:AhmedCharfeddine/dotfiles.git
cd dotfiles
./install.sh
```

## What's Included

| Package   | Description                          |
|-----------|--------------------------------------|
| `zsh`     | Zsh config with Zinit, Powerlevel10k |
| `neovim`  | Neovim config (Kickstart-based)      |
| `kitty`   | Kitty terminal configuration         |
| `tmux`    | tmux config with TPM                 |

## Optional Dependencies

- **Node.js 20+** - For Python LSP support in Neovim and Copilot

## Manual Steps

After running the installer:

1. Open a new terminal to load the Zsh configuration
2. Zinit will automatically install plugins on first run
3. Run `p10k configure` to customize the Powerlevel10k prompt
4. In Neovim, run `:Lazy` to check plugin status
5. In tmux, press `prefix + I` to install TPM plugins (tmux prefix is Ctrl Space)

## Notes

- Neovim is installed to `/opt/nvim-linux-x86_64` (requires sudo)
- Fonts are installed to `~/.local/share/fonts`
- The installer checks for Fedora but can run on other systems with confirmation

## illogical-impulse Integration (Optional)

For a full Hyprland desktop

### 1. Install illogical-impulse

```bash
bash <(curl -s https://ii.clsty.link/get)
```

Follow their prompts. This installs Hyprland, Quickshell, and base configs. Or follow the instructions at [their wiki](https://ii.clsty.link/en/ii-qs/01setup/#automated-installation)

### 2. Stow customizations on top

```bash
cd ~/dotfiles
stow hyprland  # Adds custom/ configs on top of their base
stow kitty     # Overwrites their kitty config with yours
```

If you get conflicts:

```bash
stow --adopt hyprland && git checkout -- hyprland
stow --adopt kitty && git checkout -- kitty
```

### Notes

- illogical-impulse provides base Hyprland config (`hyprland/` directory)
- This repo only tracks `hyprland/.config/hypr/custom/` for personal customizations
- Kitty uses custom configs (loses their dynamic theming)
- The repository also includes two profiles for `teams-for-linux` that you can launch by symlinking the provided desktop entries
