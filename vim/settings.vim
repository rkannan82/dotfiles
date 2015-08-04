let skip_list=['bufexplorer.vim', 'eclim.vim']

for fpath in split(globpath('$DOTFILES_DIR/vim/settings', '*.vim'), '\n')
  " Only source files that are not in skip_list
  if (index(skip_list, fnamemodify(fpath, ':t')) == -1)
    exe 'source' fpath
  endif
endfor
