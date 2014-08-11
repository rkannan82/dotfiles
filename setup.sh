#!/bin/bash -i

function backup() {
  file=$1

  if [ -f $file ]; then
    echo "$file exists. Moving to $file.$timestamp"
    mv $file $file.$timestamp
  fi
}

# Bail out on failure
set -e

basedir=${HOME}/dotfiles
timestamp=$(date "+%Y%m%d_%H%M%S")

########## bash #########
backup "${HOME}/.bashrc"
echo "######### Importing settings ##########" >> ${HOME}/.bashrc
echo ". $basedir/bash/bash_settings" >> ${HOME}/.bashrc
echo "#######################################" >> ${HOME}/.bashrc
echo "${HOME}/.bashrc setup complete"

########## vim ##########
# Install vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

backup "${HOME}/.vimrc"
ln -sf $basedir/vim/vimrc ${HOME}/.vimrc
echo "${HOME}/.vimrc setup complete"

# Use vundle to install plugins
echo "Installing VIM plugins ..."
vim +PluginInstall +qall
echo "Done"
