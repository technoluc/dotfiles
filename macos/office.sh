#!/usr/bin/env zsh

cecho "#-----------------------------------------------------------------#" $green
cecho "#                         Office                                  #" $green
cecho "#-----------------------------------------------------------------#" $green
echo ""

# Tap to click
echo ""
botq "Download, install and crack Office? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  wget -P ~/Downloads https://github.com/technoluc/macos/releases/download/v16.66/Microsoft.Office.2021.v16.66.zip
  unzip ~/Downloads/Microsoft.Office.2021.v16.66.zip -d ~/Downloads
  yes | PAGER=cat hdiutil attach ~/Downloads/Microsoft.Office*.dmg
  sudo installer -pkg /Volumes/Microsoft*/Microsoft*.pkg -target /
  sudo installer -pkg /Volumes/Microsoft*/Extra/LTSC*.pkg -target /
fi