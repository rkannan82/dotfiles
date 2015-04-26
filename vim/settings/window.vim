" Mappings {{{

" Fix issue with Ctrl-H being mapped to backspace on OSX
" by running this command in terminal
" https://github.com/neovim/neovim/issues/2048
" $ infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" $ tic $TERM.ti

" Arrow keys are bad!
nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

nmap <C-J> <PageDown>
nmap <C-K> <PageUp>
nmap <C-H> ^
nmap <C-L> $

" navigating splits using Alt-hjkl
noremap ˙ <Esc><C-W>h
noremap ∆ <Esc><C-W>j
noremap ˚ <Esc><C-W>k
noremap ¬ <Esc><C-W>l

" navigating tabs using Alt-op
noremap π <Esc>:tabnext<CR>
noremap ø <Esc>:tabprevious<CR>

" navigating splits within terminal using Alt-hjkl
tnoremap <leader><leader> <C-\><C-n>
tnoremap ˙ <C-\><C-n><C-w>h
tnoremap ∆ <C-\><C-n><C-w>j
tnoremap ˚ <C-\><C-n><C-w>k
tnoremap ¬ <C-\><C-n><C-w>l

" navigating tabs within terminal using Alt-op
tnoremap π <C-\><C-n>:tabnext<CR>
tnoremap ø <C-\><C-n>:tabprevious<CR>

" Resize vertical splits
nnoremap <silent> > :vertical resize +4<CR>
nnoremap <silent> < :vertical resize -4<CR>

" Resize hotizontal splits
nnoremap <silent> + :resize +4<CR>
nnoremap <silent> _ :resize -4<CR>

nnoremap mm :MaximizeWindow<CR>
set winminheight=0
set winminwidth=0

" close preview window
nnoremap <C-Z> <C-W>z

" close split
nnoremap <C-Q> <C-W>q
" }}}
