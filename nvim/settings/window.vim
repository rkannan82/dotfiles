augroup Terminal
  au!
  au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  au BufEnter term://* startinsert
augroup END

" Mappings {{{
" Navigating splits using Alt-hjkl
noremap <A-h> <Esc><C-W>h
noremap <A-j> <Esc><C-W>j
noremap <A-k> <Esc><C-W>k
noremap <A-l> <Esc><C-W>l

nnoremap <C-t> :tabnew<CR>
nnoremap <C-w> :tabclose<CR>

" Navigating tabs
noremap <S-right> <Esc>:tabnext<CR>
noremap <S-left> <Esc>:tabprevious<CR>

" Navigating splits within terminal using Alt-hjkl
tnoremap <leader><leader> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Navigating tabs within terminal
tnoremap <S-right> <C-\><C-n>:tabnext<CR>
tnoremap <S-left> <C-\><C-n>:tabprevious<CR>
" }}}
