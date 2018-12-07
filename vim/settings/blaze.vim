let s:google3="/usr/local/google/home/kannanr/Code/bolt.fig/google3/"
let g:blaze_lib_suffix=0

function! BlazeBuild()
  exec 'lcd '. s:google3
  let target=substitute(expand('%:p:h:r') . ':' . expand('%:t:r'), s:google3, '', '')
  " if g:blaze_lib_suffix == 1
    " let target=target . '_lib'
  " endif
  exec 'Dispatch blaze build //' . target
endfunction

function! BlazeTest()
  exec 'lcd '. s:google3
  let target=substitute(expand('%:p:h:r') . ':' . expand('%:t:r'), s:google3, '', '')
  if (matchstr (target, "_test$") == "")
    " let target=target . '_test'
  endif
  exec 'Dispatch blaze test //' . target
endfunction

function! BuildCleaner()
  exec 'lcd '. s:google3
  let target=substitute(expand('%:p:h:r') . ':' . expand('%:t:r'), s:google3, '', '')
  " if g:blaze_lib_suffix == 1
    " let target=target . '_lib'
  " endif
  exec 'Dispatch build_cleaner //' . target
endfunction

function! OpenTestLog()
  exec 'lcd '. s:google3
  let target=substitute(expand('%:p:r'), s:google3, '', '')
  if (matchstr (target, "_test$") == "")
    let target=target . '_test'
  endif
  let test_log=s:google3 . 'blaze-testlogs/' . target . '/test.log'
  " Open file and go to end.
  exec 'vsp + ' . test_log
endfunction

nnoremap <silent> <leader>bb :call BlazeBuild()<CR>
nnoremap <silent> <leader>bt :call BlazeTest()<CR>
nnoremap <silent> <leader>bc :call BuildCleaner()<CR>
nnoremap <silent> <leader>bl :call OpenTestLog()<CR>
