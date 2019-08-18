let g:ctrlp_user_command = '/usr/bin/ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ --ignore review
      \ -g ""'

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20,results:30'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_by_filename = 0
let g:ctrlp_working_path_mode = ''
let g:ctrlp_mruf_max = 20

let g:ctrlp_mruf_relative = 1
let g:ctrlp_prompt_mappings = { 'ToggleMRURelative()': ['<F2>'] }

nmap <silent> <Leader>ff :CtrlP<CR>
nmap <silent> <Leader>fr :CtrlPRoot<CR>
nmap <silent> <Leader>fb :CtrlPBuffer<CR>
nmap <silent> <Leader>fd :CtrlPBookmarkDir<CR>
