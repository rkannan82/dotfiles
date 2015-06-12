augroup Terminal
  au!
  au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  au BufEnter term://* startinsert
augroup END

" Mappings {{{
" navigating splits using Alt-hjkl
noremap ˙ <Esc><C-W>h
noremap ∆ <Esc><C-W>j
noremap ˚ <Esc><C-W>k
noremap ¬ <Esc><C-W>l

" navigating tabs using Alt-[]
noremap ‘ <Esc>:tabnext<CR>
noremap “ <Esc>:tabprevious<CR>

" navigating splits within terminal using Alt-hjkl
tnoremap <leader><leader> <C-\><C-n>
tnoremap ˙ <C-\><C-n><C-w>h
tnoremap ∆ <C-\><C-n><C-w>j
tnoremap ˚ <C-\><C-n><C-w>k
tnoremap ¬ <C-\><C-n><C-w>l

" navigating tabs within terminal using Alt-[]
tnoremap ‘ <C-\><C-n>:tabnext<CR>
tnoremap “ <C-\><C-n>:tabprevious<CR>
" }}}
