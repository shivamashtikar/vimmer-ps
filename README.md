# vimmer-ps
A support plugin for [LanguageClient_NeoVim][] which integrates [pureScript-language-server][]

<!-- vim-markdown-toc GFM -->

- [Installation](#Installation)
  - [Requirements](#Requirements)
  - [Dependencies](#Dependencies)
- [Configuration](#Configuration)

## Installation
Use your favorite plugin manager.

Using [vim-plug](https://github.com/junegunn/vim-plug):

  `Plug 'sriharshachilakapati/vimmer-ps'`

Using [vundle](https://github.com/gmarik/Vundle.vim):

  `Plugin 'sriharshachilakapati/vimmer-ps'`

Using [neobundle](https://github.com/Shougo/neobundle.vim):

  `NeoBundle 'sriharshachilakapati/vimmer-ps'`

With [pathogen.vim](https://github.com/tpope/vim-pathogen), just clone this repository inside `~/.vim/bundle`:

### Requirements

vimmers-ps requires [purescript-language-server][] to be installed <br/>
you will want to install this either globally or locally for npm, e.g.

``` bash
npm i -g purescript-language-server
```

### Dependencies
This plugin is dependent on following plugins
- [LanguageClient_NeoVim][]
- [Fzf.vim](https://github.com/junegunn/fzf.vim)
- [deoplete](https://github.com/Shougo/deoplete.nvim), (Optional for suggestions, see [LanguageClient_NeoVim][] for other completion plugins)

## Configuration
* Disable default key mapping
```vim
let g:vimmerps_disable_mappings = v:true
```
* Set Custom key bindings
```vim
    " Keybindings for IDE like functions
    " Note: following are default key bindings
   autocmd Filetype purescript nm <buffer> <silent> <leader>a :Papply<CR>
   autocmd Filetype purescript nm <buffer> <silent> <leader>i :Pimport<CR>
   autocmd Filetype purescript nm <buffer> <silent> <leader>g :call LanguageClient_textDocument_definition()<CR>
   autocmd Filetype purescript nm <buffer> <silent> <leader>h :call LanguageClient_textDocument_hover()<CR>
   autocmd Filetype purescript nm <buffer> <silent> <leader>l :Pbuild<CR>
```
* Start server if not running `:Pstart`
* Stop server `:Pend`
* Restart server `Prestart`
* Search functions `:Psearch catMaybes`
* Import function under cursor `:Pimport`
* Apply code actions `:Papply`

## Author and Feedback

If you like this plugin, please star them on Github. It's a great way of getting
feedback. Same goes for issues reports or feature requests.


[LanguageClient_NeoVim]: https://github.com/autozimu/LanguageClient-neovim
[purescript-language-server]: https://github.com/nwolverson/purescript-language-server

