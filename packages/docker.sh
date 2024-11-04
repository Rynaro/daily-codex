#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

install_package() {
  if is_wsl; then
    unpack_it "docker/wsl"
  elif is_debian_bookworm; then
    unpack_it "docker/debian"
  fi
}

install_package
