function setPlistValue {
  local plist="$HOME/Library/Preferences/com.apple.Terminal.plist"
  local profile="Basic"
  local key="$1"
  local value="$2"

  # Check if the value already exists in the profile
  local existingValue
  existingValue=$(/usr/libexec/PlistBuddy -c "Print 'Window Settings':$profile:$key" "$plist" 2>/dev/null)

  if [[ -n $existingValue ]]; then
    # Check if the existing value matches the desired value
    if [[ "$existingValue" != "$value" ]]; then
      # Value exists but is different, set it to the provided value
      echo $existingValue
      # /usr/libexec/PlistBuddy -c "Set 'Window Settings':$profile:$key $value" "$plist"
      # show_ok "$key has been updated to $value."
    else
      show_ok "$key is already set to $value."
    fi
  else
    # Value doesn't exist, add it with the provided value
    local type
    # Determine the data type based on the value
    if [[ "$value" == "YES" || "$value" == "NO" ]]; then
      type="bool"
    elif [[ "$value" == *"."* ]]; then
      type="real"
    else
      type="integer"
    fi

    /usr/libexec/PlistBuddy -c "Add 'Window Settings':$profile:$key $type $value" "$plist"
    if [ $? -ne 0 ]; then
      show_error "Failed to add $key with value $value to the plist."
    else
      show_ok "$key has been added and set to $value."
    fi
  fi
}

