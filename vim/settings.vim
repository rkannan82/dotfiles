for fpath in split(globpath('$HOME/dotfiles/vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
