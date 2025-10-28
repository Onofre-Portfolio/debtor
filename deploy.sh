#!/usr/bin/env bash

set -e

# Detect OS
OS=$(uname -s)

# Set destination directories based on OS
case "$OS" in
  Darwin)
    echo "Detected macOS"
    BIN_DIR="/usr/local/bin"
    SHARE_DIR="/usr/local/share/debtor"
    ;;
  Linux)
    echo "Detected Linux"
    BIN_DIR="/usr/local/bin"
    SHARE_DIR="/usr/local/share/debtor"
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

# Check and create share directory if it doesn't exist
if [ ! -d "$SHARE_DIR" ]; then
  echo "Creating directory: $SHARE_DIR"
  sudo mkdir -p "$SHARE_DIR"
  echo "Setting ownership to current user..."
  sudo chown -R "$USER" "$SHARE_DIR"
else
  echo "Directory already exists: $SHARE_DIR"
  echo "Ensuring proper ownership..."
  sudo chown -R "$USER" "$SHARE_DIR"
fi

# Check if bin directory exists
if [ ! -d "$BIN_DIR" ]; then
  echo "Creating directory: $BIN_DIR"
  sudo mkdir -p "$BIN_DIR"
fi

# Update cabal package list
echo "Updating cabal package list..."
cabal update

# Build the project
echo "Building debtor..."
cabal build

# Install to destination
echo "Installing debtor to $BIN_DIR..."
sudo cabal install --installdir="$BIN_DIR" --overwrite-policy=always

echo "Deployment complete! debtor installed to $BIN_DIR/debtor"
