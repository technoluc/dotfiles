#!/usr/bin/env bash

###########################################################
# Install non-brew various tools (PRE-BREW Installs)
###########################################################

bot "ensuring build/install tools are available"
if ! xcode-select --print-path &> /dev/null; then
  botc "Xcode is not installed" $red
  botc "Trying to install Xcode" $green
  xcode-select --install
  sleep 1
  osascript <<-EOD
	  tell application "System Events"
	    tell process "Install Command Line Developer Tools"
	      keystroke return
	      click button "Agree" of window "License Agreement"
	    end tell
	  end tell
EOD

fi




#    # Prompt user to install the XCode Command Line Tools
#    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? ' XCode Command Line Tools Installed'

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

#    sudo xcodebuild -license
#    print_result $? 'Agree with the XCode Command Line Tools licence'
