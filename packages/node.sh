#!/bin/bash

NODE_LTS=v20.15

# Source utilities script
safe_source "utilities.sh"

# Function to install the latest Node.js version
install_latest_node() {
  if command_exists node; then
    echo "Node already installed!"
  else
    echo "Installing the latest Node.js version..."
    nvm install $NODE_LTS
  fi
}

configure_package() {
  if command_exists yarn; then
    echo "Yarn already installed!"
  elif
    npm install -g yarn
  fi
}

install_package
configure_package
