function! ToggleNERDTreeAndTagbar()
let w:jumpbacktohere = 1

" Detect which plugins are open
if exists('t:NERDTreeBufName')
    let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
else
    let nerdtree_open = 0
endif
let tagbar_open = bufwinnr('__Tagbar__') != -1

" Perform the appropriate action
if nerdtree_open
    NERDTreeClose
    Tagbar
elseif tagbar_open
    Tagbar
    NERDTreeFind
else
    Tagbar
endif

" Jump back to the original window
for window in range(1, winnr('$'))
    execute window . 'wincmd w'
    if exists('w:jumpbacktohere')
        unlet w:jumpbacktohere
        break
    endif
endfor
endfunction

"nnoremap <silent> <leader>t :call ToggleNERDTreeAndTagbar()<CR>
"nnoremap <silent> <leader>tc :NERDTreeClose<CR>:TagbarClose<CR>
