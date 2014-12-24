" My preference with using buffers. See `:h hidden` for more details
set hidden

set switchbuf=useopen

nmap [w :bprevious<CR>
nmap ]w :bnext<CR>

nmap <silent> <Leader>q :bd<CR>
