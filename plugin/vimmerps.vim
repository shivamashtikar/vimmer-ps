if get(g:, 'vimmerpsPlugin_loaded')
    finish
endif

if !exists('g:LanguageClient_serverCommands')
    let g:LanguageClient_serverCommands = {}
endif

" Configure LanguageClient to use purescript-language-server if it is installed and available in path.
if executable("purescript-language-server") || executable("npx")
    " See https://github.com/nwolverson/vscode-ide-purescript/blob/master/package.json#L80-L246 for list of properties to use
    let config =
        \ { 'autoStartPscIde': v:true
        \ , 'pscIdePort': v:null
        \ , 'autocompleteAddImport': v:true
        \ , 'pursExe': 'purs'
        \ , 'addNpmPath': v:true
        \ }

    let configWrapper =
        \ { 'purescript': config
        \ }

    " Define the LanguageServer in the LanguageClient
    if executable("purescript-language-server")
        let g:LanguageClient_serverCommands.purescript =
            \ [ 'purescript-language-server'
            \ , '--stdio'
            \ , '--config'
            \ , json_encode(configWrapper)
            \ ]
    else
        let g:LanguageClient_serverCommands.purescript =
            \ [ 'npx'
            \ , 'purescript-language-server'
            \ , '--stdio'
            \ , '--config'
            \ , json_encode(configWrapper)
            \ ]
    endif

    let g:LanguageClient_rootMarkers.purescript = [ 'bower.json', 'psc-package.json' ]
endif

let g:vimmerpsPlugin_loaded = v:true
