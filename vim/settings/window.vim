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

" Navigating windows in a tab.
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

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
" }}}
