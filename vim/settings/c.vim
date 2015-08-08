nmap <silent> <leader>s :call <SID>SwitchFile()<CR>

function! s:SwitchFile()
  let ext=expand('%:e')
  if ext == 'h'
    edit %<.cc
  elseif ext == 'cc'
    edit %<.h
  else
    echo "Invalid switch"
  endif
endfunction
