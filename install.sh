#!/bin/zsh

# Define theme name and source file
THEME_NAME="yonko"
THEME_FILE="yonko.zsh-theme"
ZSHRC_FILE="$HOME/.zshrc"

# Oh My Zsh custom themes directory
OMZ_CUSTOM_THEMES_DIR="$HOME/.oh-my-zsh/custom/themes"

echo "Starting installation of the '$THEME_NAME' Zsh theme..."

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Error: Oh My Zsh does not appear to be installed."
  echo "Please install Oh My Zsh first: https://ohmyz.sh/"
  exit 1
fi

# Create custom themes directory if it doesn't exist
if [ ! -d "$OMZ_CUSTOM_THEMES_DIR" ]; then
  echo "Creating Oh My Zsh custom themes directory: $OMZ_CUSTOM_THEMES_DIR"
  mkdir -p "$OMZ_CUSTOM_THEMES_DIR"
  if [ $? -ne 0 ]; then
    echo "Error: Could not create custom themes directory. Please check permissions."
    exit 1
  fi
fi

# Check if the theme file exists in the current directory
if [ ! -f "$THEME_FILE" ]; then
  echo "Error: Theme file '$THEME_FILE' not found in the current directory."
  echo "Please make sure you are in the theme's repository directory when running this script."
  exit 1
fi

# Copy the theme file
echo "Copying '$THEME_FILE' to '$OMZ_CUSTOM_THEMES_DIR/$THEME_NAME.zsh-theme'..."
cp "$THEME_FILE" "$OMZ_CUSTOM_THEMES_DIR/$THEME_NAME.zsh-theme"
if [ $? -ne 0 ]; then
  echo "Error: Could not copy theme file. Please check permissions."
  exit 1
fi

echo "Theme file copied successfully."

# Check if ZSH_THEME is already set to "yonko"
echo "Checking $ZSHRC_FILE for ZSH_THEME..."
if grep -q "ZSH_THEME=\"$THEME_NAME\"" "$ZSHRC_FILE"; then
  echo "ZSH_THEME is already set to '$THEME_NAME' in $ZSHRC_FILE."
else
  echo "Setting ZSH_THEME to '$THEME_NAME' in $ZSHRC_FILE..."
  # Backup .zshrc
  cp "$ZSHRC_FILE" "$ZSHRC_FILE.bak_$(date +%Y%m%d_%H%M%S)"
  echo "Backed up $ZSHRC_FILE to $ZSHRC_FILE.bak_$(date +%Y%m%d_%H%M%S)"

  # Update ZSH_THEME
  if grep -q "^ZSH_THEME=" "$ZSHRC_FILE"; then
    # If ZSH_THEME is already set, replace its value
    sed -i -e "s|^ZSH_THEME=.*|ZSH_THEME=\"$THEME_NAME\"|" "$ZSHRC_FILE"
  else
    # If ZSH_THEME is not set, add it
    echo "\n# Set Zsh theme\nZSH_THEME=\"$THEME_NAME\"" >> "$ZSHRC_FILE"
  fi

  if [ $? -ne 0 ]; then
    echo "Error: Could not update $ZSHRC_FILE. Please check permissions or update it manually."
    exit 1
  fi
  echo "Successfully updated ZSH_THEME in $ZSHRC_FILE."
fi

echo ""
echo "Installation complete!"
echo "To apply the theme, please either:"
echo "1. Source your .zshrc file: source $ZSHRC_FILE"
echo "2. Or, close and reopen your terminal."

exit 0
