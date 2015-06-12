for fpath in split(globpath('$DOTFILES_DIR/nvim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
