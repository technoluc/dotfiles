# functions/set_finder_preferences.zsh
set_finder_preferences() {
  if prompt_robot "Customize Finder preferences?"; then
    add_prompt "Customize Finder preferences?" "set_finder_preferences"
    add_prompt "Set HOME as the default location for new Finder windows?" "defaults write com.apple.finder NewWindowTarget -string 'PfLo'; defaults write com.apple.finder NewWindowTargetPath -string 'file://${HOME}'"
    add_prompt "Show the ~/Library folder?" "chflags nohidden ~/Library"
    add_prompt "Show hidden files by default?" "defaults write com.apple.finder AppleShowAllFiles -bool true"
  fi
}
