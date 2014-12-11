" My preference with using buffers. See `:h hidden` for more details
set hidden

set switchbuf=useopen

nmap [w :bprevious<CR>
nmap ]w :bnext<CR>

" Close the current buffer and move to the last buffer that was being edited
nmap <Leader>q :bd<CR>
