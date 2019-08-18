let g:airline_theme='base16_ashes'

" {{{ tabline
let g:airline#extensions#tabline#enabled=2
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#show_tab_type=0
let g:airline#extensions#tabline#show_tab_nr=1
" For ctrlspace
let g:airline_exclude_preview = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod=':t'
" }}}

" Automatically populate the g:airline_symbols dictionary with the powerline
" symbols
let g:airline_powerline_fonts=1

let g:airline#extensions#whitespace#enabled=0

" {{{ sections
let g:airline_section_c = '%t'
let g:airline_section_y = ''
" }}}
