set t_Co=256
set background=dark
colorscheme solarized

syntax enable

"highlight CursorLine ctermfg=black ctermbg=30
"highlight Search term=reverse cterm=reverse ctermfg=10 ctermbg=0

" Used for highlighting current line being debugged
" Add it after enabling syntax. Otherwise, it will get cleared
highlight EclimDebugLine ctermfg=white ctermbg=yellow

" Override the default red color from solarized
highlight WarningMsg     ctermfg=gray

" Make the sign colum color same as line number column
highlight clear SignColumn
