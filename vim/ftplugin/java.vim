nnoremap <silent> <F5> :ProjectRefreshAll<cr>
nnoremap <silent> <leader>o :JavaImportOrganize<cr>
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
nnoremap <silent> <buffer> <leader>j :JavaFormat<cr>
nnoremap <silent> <buffer> <leader>c I//<esc> 

abbr psvm public static void main(String[] args) {<cr>
abbr sop System.out.println("");<esc>2hi
"abbr forl for (int i = 0; i < ; i++) {<esc>7hi}
"abbr tryb try {<CR>} catch (Exception e) {<CR> ex.printStackTrace();<CR>}<esc>hx3ko
"abbr ctm System.currentTimeMillis()
abbr slept try {<CR> Thread.sleep();<CR>}<esc>hxA catch(InterruptedException e) {<CR> Thread.currentThread.interrupt();<CR>}<esc>hx3k$hi
