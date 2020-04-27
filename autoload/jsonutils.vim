if get(g:, 'jsonutils_loaded')
    finish
endif

" Helper function to convert a list to JSON, returns a list
function! jsonutils#ListToJsonLines(...)
    let l:list = get(a:, 1, [])
    let l:level = get(a:, 2, 0)

    let l:lines = []
    let l:indent = join(map(range(l:level), { _ -> "  " }), "")

    if (len(l:list) == 0)
        return [ l:indent . '[]' ]
    endif

    for val in l:list
        if (type(val) == type({}))
            let l:valueLines = jsonutils#DictToJsonLines(val, l:level + 2)

            if (len(l:lines) == 0)
                let l:valueLines[0] = substitute(l:valueLines[0], "  {", "[ {", "")
            else
                let l:valueLines[0] = substitute(l:valueLines[0], "  {", ", {", "")
            endif

            call extend(l:lines, l:valueLines)
        elseif (type(val) == type([]))
            let l:valueLines = jsonutils#ListToJsonLines(val, l:level + 2)

            if (len(l:lines) == 0)
                let l:valueLines[0] = substitute(l:valueLines[0], "  [", "[ [", "")
            else
                let l:valueLines[0] = substitute(l:valueLines[0], "  [", ", [", "")
            endif

            call extend(l:lines, l:valueLines)
        else
            if (len(l:lines) == 0)
                call add(l:lines, l:indent . '[ ' . s:GetValueStr(val))
            else
                call add(l:lines, l:indent . ', ' . s:GetValueStr(val))
            endif
        endif
    endfor

    call add(l:lines, l:indent . ']')

    return l:lines
endfunction

" Helper function to convert a dict to JSON, returns a list
function! jsonutils#DictToJsonLines(...)
    let l:dict = get(a:, 1, {})
    let l:level = get(a:, 2, 0)

    let l:indent = join(map(range(l:level), { _ -> "  " }), "")
    let l:lines = []
    let l:keys = keys(l:dict)

    if (len(l:keys) == 0)
        return [ l:indent . '{}' ]
    endif

    for key in l:keys
        let l:value = get(l:dict, key, "null")

        if (type(l:value) == type({}))
            let l:valueLines = jsonutils#DictToJsonLines(l:value, l:level + 2)

            if (len(l:lines) == 0)
                call add(l:lines, l:indent . '{ "' . key . '":')
            else
                call add(l:lines, l:indent . ', "' . key . '":')
            endif

            call extend(l:lines, l:valueLines)
        elseif (type(l:value) == type([]))
            let l:valueLines = jsonutils#ListToJsonLines(l:value, l:level + 2)

            if (len(l:lines) == 0)
                call add(l:lines, l:indent . '{ "' . key . '":')
            else
                call add(l:lines, l:indent . ', "' . key . '":')
            endif

            call extend(l:lines, l:valueLines)
        else
            if (len(l:lines) == 0)
                call add(l:lines, l:indent . '{ "' . key . '": ' . s:GetValueStr(l:value))
            else
                call add(l:lines, l:indent . ', "' . key . '": ' . s:GetValueStr(l:value))
            endif
        endif
    endfor

    call add(l:lines, l:indent . '}')

    return l:lines
endfunction

function! s:GetValueStr(value)
    if (type(a:value) == type(""))
        return '"' . a:value . '"'
    else
        return "" . a:value
    endif
endfunction

let g:jsonutils_loaded = v:true
