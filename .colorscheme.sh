#!/bin/bash

# Define color options
colors=("day" "latte" "frappe" "macchiato" "mocha" "night")

# Map aliases to actual color names
case $1 in
    "day")   color="latte";;
    "night") color="mocha";;
    *)       color="$1";;
esac

# Validate color input
if [[ "$#" -ne 1 || ! " ${colors[@]} " =~ " $color " ]]; then
    echo "Usage: $0 {day|latte|frappe|macchiato|mocha|night}"
    exit 1
fi

# Set paths
dotfiles=~/.config
alacritty="${dotfiles}/alacritty"
nvim="${dotfiles}/nvim"
tmux="${dotfiles}/tmux"

# Define theme files
alacritty_theme="${alacritty}/themes/catppuccin-${color}.toml"
nvim_theme="${nvim}/lua/core/chosen_color.lua"
tmux_theme="${tmux}/tmux.conf"

# Check if theme files exist
if [ ! -f "$alacritty_theme" ]
then
    echo "Theme file not found: $alacritty_theme"
    exit 1
fi
if [ ! -f "$nvim_theme" ]
then
    echo "Theme file not found: $nvim_theme"
    exit 1
fi
if [ ! -f "$tmux_theme" ]
then
    echo "Theme file not found: $tmux_theme"
    exit 1
fi


configure_alacritty() {
    cat ${alacritty}/base.toml ${alacritty_theme} > ${alacritty}/alacritty.toml
}

configure_nvim() {
    echo "return '$color'" > ${nvim_theme}
}

configure_tmux() {
    sed -i "s/set -g @catppuccin_flavour.*/set -g @catppuccin_flavour ${color}/g" ${tmux_theme}
}

# Apply selected color
configure_alacritty
configure_nvim
configure_tmux

echo "Configuration applied for color: $color"
