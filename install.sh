#!/bin/sh

printf "This script will replace existing dotfiles. Make a backup first!\n"
read -p "Continue? (Y/N) " allowed

case $allowed in
    Y*|y*)
        cp -r config/* ~/.config
        printf "Copied configuration files!\n";;
    *) printf "Aborting!\n";;
esac