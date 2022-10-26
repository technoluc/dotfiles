#!/usr/bin/env zsh

cecho "#-----------------------------------------------------------------#" $green
cecho "#                         Terminal                                #" $green
cecho "#-----------------------------------------------------------------#" $green
echo ""

PLIST="$HOME/Library/Preferences/com.apple.Terminal.plist"
THEME=`/usr/libexec/PlistBuddy -c "Print 'Startup Window Settings'" $PLIST`

# use Option As MetaKey
echo ""
botq "use Option As MetaKey? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  /usr/libexec/PlistBuddy -c "Set 'Window Settings':${THEME}:useOptionAsMetaKey YES" $PLIST
fi

# shell Exit Action
echo ""
botq "shell Exit Action? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  /usr/libexec/PlistBuddy -c "Set 'Window Settings':${THEME}:shellExitAction 1" $PLIST
fi
