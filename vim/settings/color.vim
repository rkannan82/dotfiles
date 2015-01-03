set term=xterm-256color
set t_Co=256
set background=dark
colorscheme solarized

syntax enable

"highlight CursorLine ctermfg=white ctermbg=10

" Used for highlighting current line being debugged
" Add it after enabling syntax. Otherwise, it will get cleared
highlight EclimDebugLine ctermfg=white ctermbg=yellow

" Override the default red color from solarized
highlight WarningMsg     ctermfg=gray

" Make the sign colum color same as line number column
highlight clear SignColumn
