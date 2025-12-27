#!/bin/bash
# copy .bashrc, .bash_lib, .bash_aliases from home and overwrite it
cp -f ~/.bashrc ./.bashrc
cp -f ~/.bash_lib ./.bash_lib
cp -f ~/.bash_aliases ./.bash_aliases
echo ".bashrc, .bash_lib, .bash_aliases copied from home to ./"
