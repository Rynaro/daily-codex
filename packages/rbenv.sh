#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

# Function to install rbenv
install_package() {
  if command_exists rbenv; then
    echo "rbenv is already installed."
  else
    echo "Installing rbenv..."
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.potions/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.potions/.zshrc
    source ~/.potions/.zshrc
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
}

install_package

