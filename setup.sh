#!/bin/bash -i

function backup() {
  file=$1

  if [ -f $file ]; then
    echo "$file exists. Backing to ${dotfiles_backup_dir}"
    cp $file "${dotfiles_backup_dir}/"
  fi
}

function setupTerm() {
  git clone https://git@github.com:altercation/solarized.git $HOME/solarized
  git clone git@github.com:powerline/fonts.git $HOME/powerline-fonts

  echo "Term setup complete"
}

function setupBash() {
  backup "${HOME}/.bashrc"
  echo "######### Importing settings ##########" >> ${HOME}/.bashrc
  echo "export DOTFILES_DIR=${dotfiles_dir}" >> ${HOME}/.bashrc
  echo ". ${dotfiles_dir}/bash/bash_settings" >> ${HOME}/.bashrc
  echo "#######################################" >> ${HOME}/.bashrc

  backup "${HOME}/.bash_profile"
  ln -sf ${dotfiles_dir}/bash/bash_profile ${HOME}/.bash_profile

  echo "Bash setup complete"
}

function setupVim() {
  # Install vundle
  if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
  fi

  backup "${HOME}/.vimrc"
  ln -sf ${dotfiles_dir}/vim/vimrc ${HOME}/.vimrc

  backup "${HOME}/.nvimrc"
  ln -sf ${dotfiles_dir}/nvim/nvimrc ${HOME}/.nvimrc
  ln -sf ~/.vim ~/.nvim

  # Symlink ftplugin settings
  if [ ! -d ${HOME}/.vim/ftplugin ]; then
    mkdir -p ${HOME}/.vim/ftplugin
  fi

  files="${dotfiles_dir}/vim/ftplugin/*"
  for file in $files
  do
    ln -sf $file ${HOME}/.vim/ftplugin/
  done

  # Use vundle to install plugins
  echo "Installing VIM plugins ..."
  vim +PluginInstall +qall

  colors_dir=${HOME}/.vim/colors
  mkdir -p $colors_dir
  ln -sf ${HOME}/.vim/bundle/vim-colors-solarized/colors/solarized.vim $colors_dir/solarized.vim

  echo "VIM setup complete"
}

function setupTmux() {
  backup "${HOME}/.tmux.conf"
  ln -sf ${dotfiles_dir}/tmux/tmux.conf ${HOME}/.tmux.conf

  mkdir -p ${HOME}/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
  tmux source-file ${HOME}/.tmux.conf

  echo "Tmux setup complete"
}

function setupGit() {
  backup "${HOME}/.gitconfig"
  ln -sf ${dotfiles_dir}/git/gitconfig ${HOME}/.gitconfig
  echo "Git setup complete"
}

function setupEclim() {
  ln -sf ${dotfiles_dir}/eclim/eclimrc ${HOME}/.eclimrc
  ln -sf ${dotfiles_dir}/eclim/user.properties ${HOME}/.vim/bundle/eclim/
  echo "Eclim setup complete"
}

# Bail out on failure
set -e

dotfiles_rel_path=`dirname ${BASH_SOURCE[0]}`
dotfiles_dir=`cd ${dotfiles_rel_path} && pwd`

dotfiles_backup_dir=${HOME}/dotfiles_backup
mkdir -p ${dotfiles_backup_dir}

setupTerm
setupBash
setupVim
setupTmux
setupGit
setupEclim

echo "Done!"

bash
