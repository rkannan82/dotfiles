set hidden
set switchbuf=useopen

nmap [b :bprevious<CR>
nmap ]b :bnext<CR>

function! s:SwitchExt()
  let test_file=0
  if(matchstr (expand('%:t:r'), "_test$") != "")
     let test_file=1
  endif

  let ext=expand('%:e')
  if ext == 'h'
    edit %<.cc
  elseif ext == 'cc' && test_file != 1
    edit %<.h
  endif
endfunction

nmap <silent> <leader>s :call <SID>SwitchExt()<CR>
