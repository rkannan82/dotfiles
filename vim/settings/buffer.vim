" My preference with using buffers. See `:h hidden` for more details
set hidden

set switchbuf=useopen

nmap [b :bprevious<CR>
nmap ]b :bnext<CR>

nmap <silent> <Leader>d :bd<CR>
nmap <silent> <Leader>qo :copen<CR>
nmap <silent> <Leader>qc :cclose<CR>
