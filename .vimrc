" indenting
set smartindent

" global whitespace settings
set expandtab

" set codefolding
set foldmethod=indent
set foldlevel=99

" show tabs as special chars
set list
set listchars=tab:▸\

" incremental search
set incsearch
" highlight search
set hlsearch

" html settings
autocmd FileType html setl tabstop=2|setl shiftwidth=2|setl softtabstop=2

" css settings
autocmd FileType css setl tabstop=2|setl shiftwidth=2|setl softtabstop=2

" javascript settings
autocmd FileType javascript setl tabstop=2|setl shiftwidth=2|setl softtabstop=2

" python settings
syntax on
autocmd FileType python setl tabstop=4|setl shiftwidth=4|setl softtabstop=4

" improve goto file
map gf :e **/<cfile><CR>

" use comma for shortcuts
let mapleader = ","

com! SD !sudo /var/zimbio/START_DJANGO
map <leader>s :w<CR>:SD<CR>
map <leader>td <Plug>TaskList

set number

"Ack-grep
nmap <leader>a <Esc>:Ack!

filetype plugin on

" highlight white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Add file path to file
set modeline
set ls=2

" ignore case during search
set ignorecase

" highlight cursor
set cursorline


" vim bundle vundle
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Bundle for git gutter
Bundle 'airblade/vim-gitgutter'

" My Bundles here:


filetype plugin indent on     " required!
"
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

" Easy Tmux navigation:w
Bundle 'christoomey/vim-tmux-navigator'

" YouCompleteMe . Pluging for vim autocomplete
"Bundle 'Valloric/YouCompleteMe'
" Bundle for Jedi Autocomplet Python
" Bundle 'git://github.com/davidhalter/jedi-vim'

" Configuration for miniBufExplorer
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"map <C-S-H> :bp
"map <C-S-L> :bn
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>



" Set vim tab numbers
" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif



" Watch for changes in .vimrc and reload
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
