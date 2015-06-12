for fpath in split(globpath('$DOTFILES_DIR/vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
