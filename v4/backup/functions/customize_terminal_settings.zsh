# Function to customize Terminal settings
customize_terminal_settings() {
  if prompt_robot "Customize Terminal settings?"; then
    # Use Option As MetaKey
    if prompt_robot "Use Option As MetaKey?"; then
      # Call the function to set or add the value for useOptionAsMetaKey
      setPlistValue "useOptionAsMetaKey" "true"
      show_ok "Option As MetaKey is enabled."
    fi

    # Shell Exit Action
    if prompt_robot "Set Shell Exit Action?"; then
      # Call the function to set or add the value for shellExitAction
      setPlistValue "shellExitAction" "1"
      show_ok "Shell Exit Action is set."

    fi
  fi
}

