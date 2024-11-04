#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

# Function to install rbenv
install_package() {
  if command_exists rbenv; then
    log "rbenv is already installed."
  else
    log "Installing rbenv..."
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    write_to_sources_file 'export PATH="$HOME/.rbenv/bin:$PATH"'
    write_to_sources_file 'eval "$(rbenv init  - zsh)"'
    source $POTIONS_HOME/.zshrc

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
}

install_package

