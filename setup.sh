#!/bin/bash
mkdir -p tmp/swap tmp/undo tmp/backup vim.old bundle
for i in ~/.gvim* ~/.nvim*; do [ -e $i ] && mv $i ./nvim.old/; done
ln -sf $(pwd)/nvimrc ~/.nvimrc
ln -sf $(pwd) ~/.nvim

# Get spellfiles
mkdir -p ~/.nvim/spell
cd ~/.nvim/spell
wget http://ftp.vim.org/pub/vim/runtime/spell/{de,en}.utf-8.{spl,sug}

# Get plugins
mkdir -p ~/.nvim/autoload

wget -O ~/.nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
