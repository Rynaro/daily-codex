#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

PERSONAL_WORKSPACE_FOLDER=~/workspace/personal

# Function to install rbenv
install_package() {
  if command_exists docker; then
    echo "Installing Personal Rails Based Containers"
    git clone git@github.com:Rynaro/drun.git $PERSONAL_WORKSPACE_FOLDER/drun
  else
    echo "git and docker are required for it."
  fi
}

configure_package() {
  echo "Building drun containers!"
  docker build $PERSONAL_WORKSPACE_FOLDER/drun
}

install_package
configure_package
