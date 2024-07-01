#!/bin/bash

# Function to check if Docker is installed
is_docker_installed() {
  if command -v docker &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Function to open the Docker Desktop download page
open_docker_download_page() {
  echo "Opening Docker Desktop download page..."
  explorer.exe "https://www.docker.com/products/docker-desktop/"
}

# Function to prompt the user to install Docker Desktop
prompt_installation() {
  while true; do
    read -p "Have you installed Docker Desktop? (y/n): " yn
    case $yn in
      [Yy]* ) break;;
      [Nn]* )
        read -p "Do you want to proceed without installing Docker? (y/n): " proceed
        case $proceed in
          [Yy]* ) return 1;;
          [Nn]* ) echo "Please install Docker Desktop to continue."; sleep 5;;
          * ) echo "Please answer yes (y) or no (n).";;
        esac
        ;;
      * ) echo "Please answer yes (y) or no (n).";;
    esac
  done
  return 0
}

install_package() {
  echo "Checking if Docker is installed..."

  if is_docker_installed; then
    echo "Docker is already installed!"
  else
    echo "Docker is not installed. For security purposes proceed downloading the Desktop Client by yourself."
    open_docker_download_page
    if ! prompt_installation; then
      echo "Proceeding without Docker installation."
    fi
  fi
}

install_package
