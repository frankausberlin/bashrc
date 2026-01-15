#!/bin/bash
# copy .bashrc, .bash_lib, .bash_aliases from home and overwrite it
[[ ! -d ./scripts ]] && echo "scripts/ folder not found!" && exit 1
cp -f ~/.bashrc ./scripts/.bashrc
cp -f ~/.bash_lib ./scripts/.bash_lib
cp -f ~/.bash_aliases ./scripts/.bash_aliases
echo ".bashrc, .bash_lib, .bash_aliases copied from home to scripts/"
