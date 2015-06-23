#!/bin/bash
mkdir -p tmp/swap tmp/undo tmp/backup nvim.old

# If we are not in ~/.nvim, backup everything and symlink this folder to it
if [ "$(pwd)" != "${HOME}/.nvim" ]
then
    for i in ~/.nvim*; do [ -e $i ] && mv $i ./nvim.old/; done
    ln -sf $(pwd) ~/.nvim
fi
ln -sf $(pwd)/nvimrc ~/.nvimrc

# Create folder for viminfo file
mkdir -p ~/.nvim/files/info

# Get spellfiles
mkdir -p ~/.nvim/spell
cd ~/.nvim/spell
wget http://ftp.vim.org/pub/vim/runtime/spell/{de,en}.utf-8.{spl,sug}

# Get plugins
mkdir -p ~/.nvim/autoload

wget -O ~/.nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
