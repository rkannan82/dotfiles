" vim options {{{
let g:EclimLogLevel = 2
let g:EclimLocateFileDefaultAction = 'edit'
let g:EclimJavaSearchSingleResult = 'vsplit'
let g:EclimJavaSearchMapping = 1
let g:EclimBrowser = 'chrome'
let g:JavaImportExclude = [ "^com\.sun\..*", "^sun\..*", "^sunw\..*" ]
let g:EclimLocateFileFuzzy = 0
let g:EclimLocateFileScope = 'workspace'
let g:EclimJavaImportPackageSeparationLevel = 1
let g:EclimProjectTreeExpandPathOnOpen = 1
let g:EclimMavenPomClasspathUpdate = 0
let g:EclimVimFindSingleResult = 'vsplit'
"let g:EclimXmlValidate = 0
" }}}

" debugger mappings {{{
nnoremap <silent> <localleader>q :JavaDebugStop<CR>
nnoremap <silent> <localleader>s :JavaDebugThreadSuspend<CR>
nnoremap <silent> <localleader>r :JavaDebugThreadResume<CR>
nnoremap <silent> <localleader>b :JavaDebugBreakpointAdd<CR>
nnoremap <silent> <localleader>br :JavaDebugBreakpointRemove<CR> 
nnoremap <silent> <localleader>bg :JavaDebugBreakpointGet<CR> 
nnoremap <silent> ; :JavaDebugStep over<CR>
nnoremap <silent> <localleader>e :JavaDebugStep into<CR>
nnoremap <silent> <localleader>x :JavaDebugStep return<CR>
" }}}

" debugger configuration {{{
let g:EclimJavaDebugLineHighlight = 'EclimDebugLine'
let g:EclimJavaDebugStatusWinOrientation = 'vertical'
let g:EclimJavaDebugStatusWinWidth = '120'
" }}}
