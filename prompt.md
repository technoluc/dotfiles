Geef mij een optimale manier een script te laten genereren aan de hand van bestanden in mappen.
- build.sh moet:
  - een setup.zsh aanmaken
  - het bestand beginnen met een zsh shebang
  - een waarschuwing toevoegen dat setup.zsh een automatisch gegenereerd bestand is
  - de bestanden uit de mappen "functions" en "scripts" uitlezen en toevoegen aan setup.zsh. 
  - verwijder setup.zsh als het al bestaat en overschrijf het met de nieuwe. 

- setup.zsh moet:
  - prompt_robot vraag voor elke folder en daarna voor elk bestand in folder. 
  - 
gewenste mappenstructuur:

dotfiles
.
├── setup.zsh
├── build.sh
├── functions/
│   ├── finder/
│   │   └── preferences.zsh
│   ├── terminal/
│   │   └── preferences.zsh
│   ├── safari/
│   │   └── preferences.zsh
│   └── homebrew/
│       ├── install_homebrew.zsh
│       └── install_apps_with_homebrew.zsh
└── scripts/
    ├── main.zsh
    └── start.zsh  

voorbeelden inhoud mappen en bestanden:

scripts/
    └── start.zsh:
```zsh
# Define the robot character and colors
ROBOT=$'\e[32m\[._.]/\e[0m'
OK_ROBOT=$'\e[32m\[._.]/'
ERROR_ROBOT=$'\e[31m\[._.]/\e[0m'

prompt_robot() {
  read -r "response?${ROBOT} $1 [Y/n]: "
  if [[ $response =~ ^[Yy]$ || $response == "" ]]; then
    return 0
  else
    return 1
  fi
}
# Function to display a succes message with the robot
show_ok() {
  echo -e "$OK_ROBOT $1\e[0m"
}

# Function to display an error message with the robot
show_error() {
  echo -e "$ERROR_ROBOT Error: $1"
}

```

functions/
│   └── homebrew/
│       ├── install_homebrew.zsh:
```zsh
# Function to install Homebrew
install_homebrew() {
  if prompt_robot "Install Homebrew?"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    if [ $? -ne 0 ]; then
      show_error "Failed to install Homebrew."
      return 1
    else
      show_ok "Successfully installed Homebrew."
      return 0
    fi
  fi
}
```

scripts/
    ├── main.zsh:

```zsh
echo "Welcome to Mac Setup Script!"

echo "Follow the prompts from the robot to set up your Mac."



# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  install_homebrew
else
  show_ok "Homebrew already installed."
fi

show_ok "Mac setup is complete."
```

veel code herhaling met alle prompt_robot vragen, vooral in:
functions/
   ├── set_finder_preferences.zsh

```zsh
set_finder_preferences() {
  if prompt_robot "Customize Finder preferences?"; then
    # Set HOME as the default location for new Finder windows
    if prompt_robot "Set HOME as the default location for new Finder windows?"; then
      defaults write com.apple.finder NewWindowTarget -string "PfLo"
      defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
      show_ok "Set HOME as the default location for new Finder windows."
    fi

    # Show the ~/Library folder
    if prompt_robot "Show the ~/Library folder?"; then
      chflags nohidden ~/Library
      show_ok "Showing the ~/Library folder."
    fi

    # Show hidden files by default
    if prompt_robot "Show hidden files by default?"; then
      defaults write com.apple.finder AppleShowAllFiles -bool true
      show_ok "Showing hidden files by default."
    fi
fi
}

```

DRY!!!

set_finder_prefs() {
  prompt_with_robot "Set HOME as the default location for new Finder windows?" set_home_default
  prompt_with_robot "Show the ~/Library folder?" show_library
  prompt_with_robot "Show hidden files by default?" show_hidden_files
}

Maak een soort van woordenboek waarin de vraag van prompt robot de titel is en de then acties zijn het commando

set_finder_preferences() {
    if prompt_robot "Set HOME as the default location for new Finder windows?"; then
      defaults write com.apple.finder NewWindowTarget -string "PfLo"
      defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
      show_ok "Set HOME as the default location for new Finder windows."
    fi

    # Show the ~/Library folder
    if prompt_robot "Show the ~/Library folder?"; then
      chflags nohidden ~/Library
      show_ok "Showing the ~/Library folder."
    fi

    # Show hidden files by default
    if prompt_robot "Show hidden files by default?"; then
      defaults write com.apple.finder AppleShowAllFiles -bool true
      show_ok "Showing hidden files by default."
    fi
}
