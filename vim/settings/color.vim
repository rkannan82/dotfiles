set term=xterm-256color
set t_Co=256
set background=dark
colorscheme solarized

syntax enable

" Used for highlighting current line being debugged
" Add it after enabling syntax. Otherwise, it will get cleared
highlight EclimDebugLine ctermfg=white ctermbg=yellow
