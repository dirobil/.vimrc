set nocompatible
set number
syntax on
filetype plugin on

set tabstop=4
set shiftwidth=4
set expandtab

let mapleader = " "

noremap <C-s> <Cmd>w<CR>
nnoremap <leader>v <C-v>

" clipboard
if executable('termux-clipboard-set')
    " Копирование текста
    :vnoremap <silent> <C-c> :w !termux-clipboard-set<CR><CR>
    " Другой вариант
    " :vnoremap <silent> <C-c> y:call system('termux-clipboard-set', @")<CR>
    " :vnoremap <silent> <C-c> "ty:call system('termux-clipboard-set')<CR>
    " Вставка текста c trim
    :nnoremap <C-v> :set paste<CR>"=trim(system('termux-clipboard-get'))<CR>p:set nopaste<CR>
    :inoremap <C-v> <Cmd>set paste<CR><C-r>=trim(system('termux-clipboard-get'))<CR><Cmd>set nopaste<CR>
    " Без trim
    " :nnoremap <C-v> :set paste<CR>"=system('termux-clipboard-get')<CR>p:set nopaste<CR>
    " :inoremap <C-v> <Cmd>set paste<CR><C-r>=system('termux-clipboard-get')<CR><Cmd>set nopaste<CR>
elseif has('clipboard')
    " Копирование текста
    :vnoremap <silent> <C-c> "+y

    " Вставка текста
    :nnoremap <silent> <C-v> "+p
    :inoremap <silent> <C-v> <C-r>+    
else
    augroup TermuxCheck
        autocmd!
        autocmd VimEnter * echohl WarningMsg | echom "Внимание: termux-api не найден; -clipboard не поддерживается. Буфер обмена Android отключен." | echohl None
    augroup END
endif
