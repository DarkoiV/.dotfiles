#!/usr/bin/env bash

SCRIPT_PATH=$(realpath "$0")
SOURCE_DIR=$(dirname "$SCRIPT_PATH") 
CONFIG_DIR="$HOME/.config"

# NEOVIM LINK
ln -s $SOURCE_DIR/nvim $CONFIG_DIR/nvim
