# vimmer-ps

A support plugin for [LanguageClient_NeoVim][] which integrates [pureScript-language-server][] for easy access to a PureScript development environment with Vim/NeoVim.

<!-- vim-markdown-toc GFM -->

- [Installation](#Installation)
  - [Requirements](#Requirements)
  - [Dependencies](#Dependencies)
- [Configuration](#Configuration)
- [Commands](#Commands)

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

vimmers-ps requires [purescript-language-server][] to be installed. You will want to install this either globally or locally for npm, e.g.

```bash
npm i -g purescript-language-server
```

If you are a yarn user, do this instead.

```bash
yarn global add purescript-language-server
```

### Dependencies

This plugin is dependent on the following plugins

- [LanguageClient_NeoVim][]
- [Fzf.vim](https://github.com/junegunn/fzf.vim)
- [deoplete](https://github.com/Shougo/deoplete.nvim), (Optional for suggestions, see [LanguageClient_NeoVim][] for other completion plugins)

## Configuration

This plugin adds some default Keybindings that we prefer at work. If these conflict with yours or you wanted to customize them, then you can disable default key mapping and set your own.

```vim
let g:vimmerps_disable_mappings = v:true
```

Here is how this plugin sets the default Keybindings. You can modify them to suite your own taste.

```vim
" Note: following are default key bindings
autocmd filetype purescript nm <buffer> <silent> <leader>a :Papply<CR>
autocmd filetype purescript nm <buffer> <silent> <leader>i :Pimport<CR>
autocmd filetype purescript nm <buffer> <silent> <leader>g :call LanguageClient_textDocument_definition()<CR>
autocmd filetype purescript nm <buffer> <silent> <leader>h :call LanguageClient_textDocument_hover()<CR>
autocmd filetype purescript nm <buffer> <silent> <leader>l :Pbuild<CR>
```

## Commands

This command registers some buffer commands. Here's a list of them.

* Start server if not running `:Pstart`
* Stop server `:Pend`
* Restart server `Prestart`
* Search functions `:Psearch catMaybes`
* Import functions, type classes, datatypes with `:Pimport`
* Apply code actions `:Papply`
* Issue custom commands directly to language-server with `:Pcommand`

## Author and Feedback

If you like this plugin, please star it on Github. Also please give a star to all the awesome plugins we depend on. It's a great way of encouraging people. Same goes for issues reports or feature requests.

[LanguageClient_NeoVim]: https://github.com/autozimu/LanguageClient-neovim
[purescript-language-server]: https://github.com/nwolverson/purescript-language-server

