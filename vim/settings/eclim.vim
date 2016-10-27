" vim options {{{
"let g:EclimLogLevel = 2
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimLocateFileDefaultAction = 'edit'
let g:EclimJavaSearchSingleResult = 'split'
let g:EclimScalaSearchSingleResult = 'split'
let g:EclimBrowser = 'chrome'
let g:JavaImportExclude = [ "^com\.sun\..*", "^sun\..*", "^sunw\..*" ]
let g:EclimLocateFileFuzzy = 0
let g:EclimLocateFileScope = 'workspace'
let g:EclimJavaImportPackageSeparationLevel = 1
let g:EclimProjectTreeExpandPathOnOpen = 1
let g:EclimMavenPomClasspathUpdate = 1
let g:EclimXmlValidate = 1
let g:EclimLoclistSignText = '!'
let g:EclimValidateSortResults = 'severity'
" }}}

" mappings {{{
nnoremap <silent> <F5> :ProjectRefreshAll<cr>
nnoremap <leader>f :LocateFile<CR>
" }}}

" debugger mappings {{{
nnoremap <silent> <localleader>q :JavaDebugStop<CR>
nnoremap <silent> <localleader>s :JavaDebugThreadSuspend<CR>
nnoremap <silent> <localleader>r :JavaDebugThreadResume<CR>
nnoremap <silent> <localleader>t :JavaDebugBreakpointToggle<CR>
nnoremap <silent> <localleader>b :JavaDebugBreakpointsList!<CR>
nnoremap <silent> ; :JavaDebugStep over<CR>
nnoremap <silent> <localleader>e :JavaDebugStep into<CR>
nnoremap <silent> <localleader>x :JavaDebugStep return<CR>
" }}}

" debugger configuration {{{
let g:EclimJavaDebugLineHighlight = 'EclimDebugLine'
let g:EclimJavaDebugLineSignText = '▸'
let g:EclimJavaDebugStatusWinOrientation = 'vertical'
let g:EclimJavaDebugStatusWinWidth = '120'
" }}}
