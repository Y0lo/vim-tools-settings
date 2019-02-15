set iminsert=0
set imsearch=0
set hlsearch
set ve=all "Set visual edit block all

"highlight lCursor guifg=NONE guibg=Cyan
"set fileencoding=utf-8
"set encoding=utf-8
"set termencoding=utf-8

" Hilight trailing whitspaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
let c_space_errors = 1

command Trimtws %s/\s\+$//g
command Findtws /\s\+$

map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
nmap <F8> :TagbarToggle<CR>

" File explorer
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" " Toggle Vexplore with Ctrl-E
" function! ToggleVExplorer()
"   if exists("t:expl_buf_num")
"       let expl_win_num = bufwinnr(t:expl_buf_num)
"       if expl_win_num != -1
"           let cur_win_nr = winnr()
"           "exec expl_win_num . 'wincmd w'
"           close
"           "exec cur_win_nr . 'wincmd w'
"           unlet t:expl_buf_num
"       else
"           unlet t:expl_buf_num
"       endif
"   else
"       exec '1wincmd w'
"       Vexplore
"       let t:expl_buf_num = bufnr("%")
"   endif
" endfunction
" set autochdir
" nmap <F9> :call ToggleVExplorer()<CR>

" File encoding
if has("multi_byte")
    if &termencoding == ""
    let &termencoding = &encoding
endif
    set encoding=utf-8
    setglobal fileencoding=utf-8 bomb
    set fileencodings=utf-8,cp1251,koi8-r,latin1
    set fileformats=dos,unix,mac
endif

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
au FileType javascript,html setl sw=2 sts=2 et

"if !has("gui_running")
if !empty($CONEMUBUILD)
    set term=xterm
	inoremap <Char-0x07F> <BS>
	nnoremap <Char-0x07F> <BS>
    set backspace=indent,eol,start
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set mouse=a
	set nocompatible
	colorscheme zenburn
endif

set number
set cursorline

"set list
"set listchars=tab:\|\

" Setting some decent VIM settings for programming

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
"set ruler                       " show the cursor position all the time
"set laststatus=2                " make the last line where the status is two lines deep so you can see status always
"set backspace=indent,eol,start  " make that backspace key work the way it should
"set nocompatible                " vi compatible is LAME
"set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
syntax on                       " turn syntax highlighting on by default

" Show EOL type and last modified timestamp, right after the filename
" set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
endfunction

