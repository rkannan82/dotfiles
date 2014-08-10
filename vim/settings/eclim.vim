" java debugger
nmap <localleader>s :JavaDebugControl stop<CR>
nmap <localleader>r :JavaDebugControl resume<CR>
nmap <localleader>t :JavaDebugControl terminate<CR>
nmap <localleader>b :JavaDebugToggleBreakpoint<CR>
nmap <localleader>v :JavaDebugVars<CR>
nmap <localleader>f :JavaDebugStackFrame<CR>
nmap <localleader>bd :JavaDebugBreakpoint delete_all<CR> 
nmap <localleader>bg :JavaDebugBreakpoint get_all<CR> 
nmap ; :JavaDebugStep over<CR>
nmap <localleader>si :JavaDebugStep into<CR>
nmap <localleader>so :JavaDebugStep return<CR>
