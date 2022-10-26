#!/usr/bin/env zsh

cecho "#-----------------------------------------------------------------#" $green
cecho "#                            Git Clone                            #" $green
cecho "#-----------------------------------------------------------------#" $green
echo ""

# Clone dotfiles repo
botc "Cloning dotfiles repo to ~/.dotfiles"
git clone --recursive git@github.com:technoluc/dotfiles.git ~/.dotfiles