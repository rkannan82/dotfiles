" My preference with using buffers. See `:h hidden` for more details
set hidden

set switchbuf=useopen

noremap <C-n> :bnext<CR>
noremap <C-p> :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
"nmap <leader>bq :bp <BAR> bd #<CR>
nmap q :bp <BAR> bd #<CR>
