#!/usr/bin/python3

import os
import shutil
import subprocess

# Paths/directories
HOME_DIR = os.environ["HOME"]
NVIM_CONFIG_DIR = os.path.join(HOME_DIR, ".config", "nvim")
NVIM_CONFIG_PATH = os.path.join(NVIM_CONFIG_DIR, "init.lua")
NVIM_PLUGIN_DIR = os.path.join(
    HOME_DIR, ".local", "share", "nvim", "site", "pack", "plugins", "start"
)

GIT_CLONE = ["git", "clone"]


def create_config_directory():
    print(f"Creating config directory: {NVIM_CONFIG_DIR}")

    try:
        os.makedirs(NVIM_CONFIG_DIR)
    except FileExistsError:
        print(f"Directory {NVIM_CONFIG_DIR} already exists")


def prompt_user_overwrite():
    print(f"File {NVIM_CONFIG_PATH} already exists")

    user_input = None

    while user_input != "y" or user_input != "n":
        user_input = input("Overwrite file? [Y]es/[N]o \n").lower()

        if user_input == "y":
            return True
        if user_input == "n":
            return False
        else:
            print("Please enter 'y' for yes or 'n' for no")


def setup_config_file():
    file_exists = os.path.exists(NVIM_CONFIG_PATH)

    if file_exists:
        should_overwrite = prompt_user_overwrite()

        if not should_overwrite:
            print("Skipped init.lua file")
            return

    # If file doesn't exist OR user want to overwrite existing file, copy init.lua to ~/.config/nvim/init.lua
    print(f"Writing init.lua file to {NVIM_CONFIG_PATH}")

    shutil.copy("init.lua", NVIM_CONFIG_PATH)


def create_plugin_directory():
    print(f"Creating plugin directory: {NVIM_PLUGIN_DIR}")

    try:
        os.makedirs(NVIM_PLUGIN_DIR)
    except FileExistsError:
        print(f"Directory {NVIM_PLUGIN_DIR} already exists")


def install_plugins(file_path):
    lines = []

    with open(file_path) as file:
        lines = file.read().splitlines()

    for line in lines:
        [plugin_name, plugin_repo] = line.split(" ")
        print(f"\nInstalling plugin: {plugin_name}\n")
        target_dir = os.path.join(NVIM_PLUGIN_DIR, plugin_name)
        result = subprocess.run(GIT_CLONE + [plugin_repo, target_dir])


print("\n===== Setting up directory for Neovim config =====")
create_config_directory()

print("===== Setting up Neovim config file =====")
setup_config_file()

print("===== Setting up Neovim Plugin directory =====")
create_plugin_directory()

print("===== Installing Neovim Plugins =====")
install_plugins("plugins.txt")

print("===== Neovim setup finished ======")
