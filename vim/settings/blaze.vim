let g:blaze_lib_suffix=0

function! BlazeBuild()
  let target=substitute(expand('%:p:h:r') . ':' . expand('%:t:r'), g:citc_workspace, '', '')
  if g:blaze_lib_suffix == 1
    let target=target . '_lib'
  endif
  exec 'Dispatch blaze build //' . target
endfunction

function! BlazeTest()
  let target=substitute(expand('%:p:h:r') . ':' . expand('%:t:r'), g:citc_workspace, '', '')
  if (matchstr (target, "_test$") == "")
    let target=target . '_test'
  endif
  exec 'Dispatch blaze test //' . target
endfunction

function! BuildCleaner()
  let target=substitute(expand('%:p:h:r') . ':' . expand('%:t:r'), g:citc_workspace, '', '')
  if g:blaze_lib_suffix == 1
    let target=target . '_lib'
  endif
  exec 'Dispatch build_cleaner //' . target
endfunction

function! OpenTestLog()
  let target=substitute(expand('%:p:r'), g:citc_workspace, '', '')
  if (matchstr (target, "_test$") == "")
    let target=target . '_test'
  endif
  let test_log=g:citc_workspace . 'blaze-testlogs/' . target . '/test.log'
  " Open file and go to end.
  exec 'vsp + ' . test_log
endfunction

nnoremap <silent> <leader>bb :call BlazeBuild()<CR>
nnoremap <silent> <leader>bt :call BlazeTest()<CR>
nnoremap <silent> <leader>bc :call BuildCleaner()<CR>
nnoremap <silent> <leader>bl :call OpenTestLog()<CR>
