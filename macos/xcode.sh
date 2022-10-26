#!/usr/bin/env bash

###########################################################
# Install non-brew various tools (PRE-BREW Installs)
###########################################################

bot "ensuring build/install tools are available"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  echo "Xcode CLI tools not found. Installing them..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    cut -c 8- | 
    tr -d '\n')
  softwareupdate -i "$PROD" --verbose;
else
  echo "Xcode CLI tools OK"
fi




#    # Prompt user to install the XCode Command Line Tools
#    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#    # Wait until the XCode Command Line Tools are installed
#    until xcode-select --print-path &> /dev/null; do
#        sleep 5
#    done

#    print_result $? ' XCode Command Line Tools Installed'

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

#    sudo xcodebuild -license
#    print_result $? 'Agree with the XCode Command Line Tools licence'
