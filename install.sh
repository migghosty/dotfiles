#!/bin/bash

################################################
# FILENAME: install.sh
#
# DESCRIPTION:
#   setup machine quickly. This is primarily used
#   on fresh Ubuntu machine and other distros
#   should proceed with caution when running this.
################################################

##################################
# REQUIREMENTS
#   install necessary packages
##################################
sudo apt update -y

sudo apt install curl -y &&
    sudo apt install git -y && \
    sudo apt install vim -y && \
    sudo apt install neovim -y && \
    sudo apt install tmux

##################################
# DOTFILES
#   setup dotfiles with tracking
##################################

# BASH
if [ -f ~/.bashrc ]; then mv ~/.bashrc ~/.bashrc.bck ; fi
ln -s ~/.dotfiles/.bashrc ~/.bashrc

# GIT
if [ -f ~/.gitconfig ]; then mv ~/.gitconfig ~/.gitconfig.bck ; fi
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# VIM
if [ -f ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.bck ; fi
ln -s ~/.dotfiles/.vimrc ~/.vimrc

# NEOVIM
if [ -d ~/.config/nvim ]; then
    if [ -f ~/.config/nvim/init.vim ]; then mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bck ; fi
    ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
else
    mkdir -p ~/.config/nvim
    ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
fi

# TMUX
if [ -f ~/.tmux.conf ]; then mv ~/.tmux.conf ~/.tmux.conf.bck ; fi
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
