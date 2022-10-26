#!/usr/bin/env zsh

cecho "#-----------------------------------------------------------------#" $green
cecho "#                           Dock                                  #" $green
cecho "#-----------------------------------------------------------------#" $green
echo ""

# reset all
echo ""
botq "Reset Dock to default? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults delete com.apple.dock; killall Dock
fi

# Hide recent apps
echo ""
botq "Hide recent apps? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.dock show-recents -bool FALSE
fi

# clear items
echo ""
botq "Clear Dock? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.dock persistent-apps -array
  defaults write com.apple.dock persistent-others -array
fi

# Add Applications to Dock
echo ""
botq "Add Applications to Dock? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  for dockItem in {/System/Applications/Launchpad,/System/Cryptexes/App/System/Applications/Safari,/System/Applications/{"Messages","Mail","Notes"},/Applications/{"Spotify","Visual Studio Code","Brave Browser","Notion","Microsoft Remote Desktop","Termius","Microsoft Word","Microsoft Excel","Microsoft OneNote"},/System/Applications/Utilities/Terminal,/System/Applications/{"App Store","System Settings"}}.app 
  do
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>'$dockItem'</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
  done
fi

# Add Applications and Download folders
echo ""
botq "Add Applications and Download folders next to bin? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.dock 'persistent-others' -array-add '<dict><key>tile-data</key><dict><key>arrangement</key><integer>0</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/</string><key>_CFURLStringType</key><integer>0</integer></dict><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>0</integer></dict><key>tile-type</key><string>directory-tile</string></dict>'
  defaults write com.apple.dock 'persistent-others' -array-add '<dict><key>tile-data</key><dict><key>arrangement</key><integer>0</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>/Users/luckurstjens/Downloads/</string><key>_CFURLStringType</key><integer>0</integer></dict><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>0</integer></dict><key>tile-type</key><string>directory-tile</string></dict>'
fi

# Set Dock icon size
echo ""
botq "Set Dock icon size to 45px? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.dock tilesize -int 45
fi


killall Dock