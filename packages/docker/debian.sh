#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

install_package() {
  sudo snap install docker
}

configure_package() {
  log 'Configuring Snap Docker daemon'
  sudo addgroup --system docker
  sudo adduser $USER docker
  newgrp docker
  sudo snap disable docker
  sudo snap enable docker
}

if command_exists docker; then
  log 'Docker is already available!'
else
  install_package
  configure_package
fi
