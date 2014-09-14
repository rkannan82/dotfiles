#!/bin/bash -i

function backup() {
  file=$1

  if [ -f $file ]; then
    echo "$file exists. Backing to $file.back"
    cp $file "$file.back"
  fi
}

function setupBash() {
  backup "${HOME}/.bashrc"
  echo "######### Importing settings ##########" >> ${HOME}/.bashrc
  echo ". $base_dir/bash/bash_settings" >> ${HOME}/.bashrc
  echo "#######################################" >> ${HOME}/.bashrc
  bash

  echo "Bash setup complete"
}

function setupVim() {
  # Install vundle
  if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
  fi

  backup "${HOME}/.vimrc"
  ln -sf $base_dir/vim/vimrc ${HOME}/.vimrc

  # Symlink ftplugin settings
  if [ ! -d ${HOME}/.vim/ftplugin ]; then
    mkdir -p ${HOME}/.vim/ftplugin
  fi

  files="$base_dir/vim/ftplugin/*"
  for file in $files
  do
    ln -s $file ${HOME}/.vim/ftplugin/
  done

  # Use vundle to install plugins
  echo "Installing VIM plugins ..."
  vim +PluginInstall +qall

  echo "VIM setup complete"
}

function setupTmux() {
  backup "${HOME}/.tmux.conf"
  ln -sf $base_dir/tmux/tmux.conf ${HOME}/.tmux.conf
  echo "Tmux setup complete"
}

function setupGit() {
  backup "${HOME}/.gitconfig"
  ln -sf $base_dir/git/gitconfig ${HOME}/.gitconfig
  echo "Git setup complete"
}

# Bail out on failure
set -e

base_dir=${HOME}/dotfiles
timestamp=$(date "+%Y%m%d_%H%M%S")

setupBash
setupVim
setupTmux
setupGit

echo "Done!"