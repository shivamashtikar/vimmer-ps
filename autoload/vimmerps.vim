if get(g:, 'VimmerPS_loaded')
    finish
endif

" Callback function used for imports. Calls FZF if there are ambigous imports and resolves with selected one
function! vimmerps#PaddImportCallback(ident, result)
    " If the result is empty, then early exit
    if (type(a:result["result"]) == type(v:null))
        return
    endif

    " There are ambigous imports, call FZF with default FZF options
    call fzf#run(fzf#wrap({ 'source': a:result["result"],
                \ 'sink': { module -> vimmerps#PaddImport(a:ident, module) }
                \ }))
endfunction

" Callback function used for Psearch function
function! vimmerps#PsearchCallback(result)
    if (type(a:result["result"]) == type(v:null))
        echom "No result(s) found"
        return
    endif

    let l:resp = a:result["result"]
    let l:lines = []

    for result in l:resp
        call add(l:lines, "module " . result["mod"] . " where")
        call add(l:lines, "  " . result["identifier"] . " :: " . result["typ"])
        call add(l:lines, "")
    endfor

    call preview#ShowInPreview("Psearch", "purescript", l:lines)
endfunction

" Callback function used for testing the LS response. Just echoes the encoded message in preview window
function! vimmerps#PlogCallback(result)
    call preview#ShowInPreview("LS response", "json", jsonutils#DictToJsonLines(a:result))
endfunction

" Functions for the rest of commands
function! vimmerps#PaddImport(...)
    let l:name = a:0 == 0 ? expand('<cword>') : get(a:, 1)
    let l:module = a:0 == 2 ? get(a:, 2) : v:null

    call LanguageClient_workspace_executeCommand(
        \ 'purescript.addCompletionImport', [ l:name, l:module, v:null, 'file://' . expand('%:p') ],
        \ { result -> vimmerps#PaddImportCallback(l:name, result) })
endfunction

function! vimmerps#Pstart()
    call LanguageClient_workspace_executeCommand('purescript.startPscIde', [])
endfunction

function! vimmerps#Pend()
    call LanguageClient_workspace_executeCommand('purescript.stopPscIde', [])
endfunction

function! vimmerps#Prestart()
    call LanguageClient_workspace_executeCommand('purescript.restartPscIde', [])
endfunction

function! vimmerps#Pbuild()
    call LanguageClient_workspace_executeCommand('purescript.build', [])
endfunction

function! vimmerps#Psearch(identifier)
    call LanguageClient_workspace_executeCommand('purescript.search', [ a:identifier ], function("vimmerps#PsearchCallback"))
endfunction

function! vimmerps#PLSCommand(command, ...)
    let l:args = a:000
    call LanguageClient_workspace_executeCommand(a:command, l:args, function("vimmerps#PlogCallback"))
endfunction

let g:VimmerPS_loaded = v:true
