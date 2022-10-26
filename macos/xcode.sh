#!/usr/bin/env bash

###########################################################
# Install non-brew various tools (PRE-BREW Installs)
###########################################################

bot "ensuring build/install tools are available"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  bot "Xcode CLI tools not found. Installing them..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    cut -c 8- | 
    tr -d '\n')
  softwareupdate -i "$PROD" --verbose
  ok "Xcode CLI tools installed";
else
  ok "Xcode CLI tools OK"
fi