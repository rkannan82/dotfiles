" Mappings {{{

" Arrow keys are bad!
nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

nmap <C-J> <PageDown>
nmap <C-K> <PageUp>
nmap <C-H> ^
nmap <C-L> $

" navigating splits
nnoremap <A-J> <C-W>j
nnoremap <A-K> <C-W>k
nnoremap <A-H> <C-W>h
nnoremap <A-L> <C-W>l

" Resize current window
nnoremap <silent> > :vertical resize +4<CR>
nnoremap <silent> < :vertical resize -4<CR>

nnoremap mm :MaximizeWindow<CR>
set winminheight=0
set winminwidth=0

" close preview window
nnoremap <C-Z> <C-W>z

" close split
nnoremap <C-Q> <C-W>q
" }}}

" Tab formating {{{
function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label = bufname(buflist[winnr - 1])
  return fnamemodify(label, ":t")
endfunction

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

set tabline=%!MyTabLine()
" }}}
