#!/bin/bash -i

function backup() {
  file=$1

  if [ -f $file ]; then
    echo "$file exists. Moving to $file.back"
    mv $file "$file.back"
  fi
}

function setupBash() {
  backup "${HOME}/.bashrc"
  echo "######### Importing settings ##########" >> ${HOME}/.bashrc
  echo ". $basedir/bash/bash_settings" >> ${HOME}/.bashrc
  echo "#######################################" >> ${HOME}/.bashrc

  echo "Bash setup complete"
}

function setupVim() {
  # Install vundle
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  backup "${HOME}/.vimrc"
  ln -sf $basedir/vim/vimrc ${HOME}/.vimrc

  # Symlink ftplugin settings
  files=${HOME}/vim/ftplugin/*
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
  ln -sf $basedir/tmux/tmux.conf ${HOME}/.tmux.conf
  echo "Tmux setup complete"
}

function setupGit() {
  backup "${HOME}/.gitconfig"
  ln -sf $basedir/git/gitconfig ${HOME}/.gitconfig
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
