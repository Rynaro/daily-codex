#!/bin/bash

NVM_VERSION=0.39.7

# Source utilities script
safe_source "utilities.sh"

# Function to install NVM
install_package() {
  if [ -d "$NVM_DIR" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "NVM is already installed."
  else
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi
}

install_package

