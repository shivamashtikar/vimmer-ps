if get(b:, 'vimmerps_ftplugin_loaded')
    finish
endif

if !exists('g:vimmerps_disable_mappings')
    let g:vimmerps_disable_mappings = v:false
endif

" This is to allow expand('<cword>') to include operators
setl isk+=.,48-57,<,>,$,#,+,-,*,/,%,',&,=,!,:,124,~,?,^

" Set the omnifunc
setl omnifunc=LanguageClient#complete

" Create the commands
com! -buffer -nargs=0 Papply call LanguageClient_textDocument_codeAction()
com! -buffer -nargs=* Pimport call vimmerps#PaddImport(<f-args>)
com! -buffer -nargs=* PimportModule call vimmerps#PaddModuleImport(<f-args>)
com! -buffer -nargs=0 Pbuild call vimmerps#Pbuild()
com! -buffer -nargs=0 Pstart call vimmerps#Pstart()
com! -buffer -nargs=0 Pend call vimmerps#Pend()
com! -buffer -nargs=0 Prestart call vimmerps#Prestart()
com! -buffer -nargs=1 Psearch call vimmerps#Psearch(<q-args>)
com! -buffer -nargs=+ Pcommand call vimmerps#PLSCommand(<f-args>)

if !g:vimmerps_disable_mappings
    " Keybindings for IDE like funtions
    nm <buffer> <silent> <leader>a :Papply<CR>
    nm <buffer> <silent> <leader>i :Pimport<CR>
    nm <buffer> <silent> <leader>g :call LanguageClient_textDocument_definition()<CR>
    nm <buffer> <silent> <leader>h :call LanguageClient_textDocument_hover()<CR>
    nm <buffer> <silent> <leader>l :Pbuild<CR>
endif

let b:vimmerps_ftplugin_loaded = v:true
