call plug#begin('~/.nvim/plugged')

""" Sensible defaults
Plug 'tpope/vim-sensible'

let g:tex_fold_enabled=1
let g:fastfold_togglehook = 0
let g:fastfold_savehook = 1
Plug 'Konfekt/FastFold'

" Better navigation in help files
Plug 'dahu/vim-help'

" Show a list of last open files when no file is opened at start
Plug 'mhinz/vim-startify'
" Ask if you wanted to open a different file when you open non-existant files
Plug 'EinfachToll/DidYouMean'

Plug 'floobits/floobits-neovim'

" Display images as ASCII in vim
Plug 'ashisha/image.vim'

""" Easymotion """
Plug 'Lokaltog/vim-easymotion'

" Plug 'YankRing.vim'
Plug 'maxbrunsfeld/vim-yankstack'

Plug 'DataWraith/auto_mkdir'

""" Fugitive """
command! Gpush Git push
command! Gpull Git pull
Plug 'tpope/vim-fugitive'

Plug 'terryma/vim-multiple-cursors'

Plug 'BlueCatMe/TempKeyword'
if has('gui_running')
    au VimEnter * call DeclareTempKeyword('1', 'bold', 'lightyellow', 'Black')
    au VimEnter * call DeclareTempKeyword('2', 'bold', 'green', 'Black')
    au VimEnter * call DeclareTempKeyword('3', 'bold', 'lightgreen', 'Black')
    au VimEnter * call DeclareTempKeyword('4', 'bold', 'brown', 'Black')
    au VimEnter * call DeclareTempKeyword('5', 'bold', 'lightmagenta', 'Black')
    au VimEnter * call DeclareTempKeyword('6', 'bold', 'lightcyan', 'Black')
else
    au VimEnter * call DeclareTempKeyword('1', 'bold', 'lightyellow', 16)
    au VimEnter * call DeclareTempKeyword('2', 'bold', 'green', 16)
    au VimEnter * call DeclareTempKeyword('3', 'bold', 'lightgreen', 16)
    au VimEnter * call DeclareTempKeyword('4', 'bold', 'brown', 16)
    au VimEnter * call DeclareTempKeyword('5', 'bold', 'lightmagenta', 16)
    au VimEnter * call DeclareTempKeyword('6', 'bold', 'lightcyan', 16)
endif
au VimEnter * call DeclareTempKeyword('7', 'bold', 'White', 'DarkRed')
au VimEnter * call DeclareTempKeyword('8', 'bold', 'White', 'DarkGreen')
au VimEnter * call DeclareTempKeyword('9', 'bold', 'White', 'DarkBlue')
au VimEnter * call DeclareTempKeyword('0', 'bold', 'White', 'DarkMagenta')

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'

" Extend the global default (NOTE: Remove comments in dictionary before sourcing)
au VimEnter * call expand_region#custom_text_objects({ 'a]' :1, 'ab' :1, 'aB' :1, 'a<' : 1 }) ">
vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)
Plug 'terryma/vim-expand-region'

" Plug 'sjl/gundo.vim'
"Plug 'simnalamburt/vim-mundo'
Plug 'dsummersl/gundo.vim'
let g:undotree_WindowLayout=2
Plug 'mbbill/undotree'

Plug 'tpope/vim-characterize'


function! s:goyo_enter()
  silent !tmux set status off
  set listchars=""
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  set listchars="tab:» ,trail:…,eol:¬,extends:>,precedes:<"
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()

Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'


"""" Searching and Highlight Stuff start



        " let g:incsearch#auto_nohlsearch = 0
        " let g:incsearch#consistent_n_direction = 1
        " map /  <Plug>(incsearch-forward)
        " map ?  <Plug>(incsearch-backward)
        " map g/ <Plug>(incsearch-stay)
        " map <silent> n :set hlsearch<CR><Plug>(incsearch-nohl-n)<Plug>Pulse
        " map <silent> N :set hlsearch<CR><Plug>(incsearch-nohl-N)<Plug>Pulse
        " " nnoremap <silent> n :set hlsearch<CR>n
        " " nnoremap <silent> N :set hlsearch<CR>N
        " map <silent> #  <Plug>(incsearch-nohl-#):set hlsearch<CR><Plug>Pulse
        " map <silent> g# <Plug>(incsearch-nohl-g#):set hlsearch<CR><Plug>Pulse
        " Plug 'haya14busa/incsearch.vim'
        "
Plug 'inside/vim-search-pulse'
let g:vim_search_pulse_mode = 'pattern'
let g:vim_search_pulse_duration = 100
let g:vim_search_pulse_disable_auto_mappings = 1
let g:vim_search_pulse_color_list = [47, 48, 49, 50, 51]
let g:vim_search_pulse_color_list = [9, 10, 9]
" nmap <silent> n n<Plug>Pulse
" nmap <silent> N N<Plug>Pulse
" Pulses cursor line on first match when doing search with / or ?
" cmap <enter> <Plug>PulseFirst
"
" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap zz mzzMzvzz12<c-e>`z:Pulse<cr>

" Pulse Line
function! s:Pulse()
    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor

    execute 'hi ' . old_hi
  endfunction
command! -nargs=0 Pulse call s:Pulse()

"Plug 'ivyl/vim-bling'

Plug 'amix/open_file_under_cursor.vim'

let g:oblique#incsearch_highlight_all=1
let g:oblique#clear_highlight=0

au VimEnter * omap <leader>/ <Plug>(Oblique-F/)
au VimEnter * xmap <leader>/ <Plug>(Oblique-F/)
au VimEnter * nmap <leader>/ <Plug>(Oblique-F/)
au VimEnter * omap <leader>? <Plug>(Oblique-F?)
au VimEnter * xmap <leader>? <Plug>(Oblique-F?)
au VimEnter * nmap <leader>? <Plug>(Oblique-F?)

au VimEnter * xmap n <Plug>(Oblique-n)<Plug>Pulse
au VimEnter * nmap n <Plug>(Oblique-n)<Plug>Pulse
au VimEnter * xmap N <Plug>(Oblique-N)<Plug>Pulse
au VimEnter * nmap N <Plug>(Oblique-N)<Plug>Pulse

Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'




""" Searching and Highlight Stuff end




""" Vim Colors (Colorschemes) """
Plug 'spf13/vim-colors'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'lsdr/monokai'
Plug 'w0ng/vim-hybrid'
Plug 'Lokaltog/vim-distinguished'
Plug 'vim-scripts/mayansmoke'
Plug 'therubymug/vim-pyte'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sjl/badwolf'
Plug 'whatyouhide/vim-gotham'

""" Colorscheme Approximation """
" This transforms colorschemes to terminal colorschemes
" The ctermbg=NONE hooks make backgrounds transparent in terminals
Plug 'godlygeek/csapprox'
let g:CSApprox_hook_post = [
            \ 'highlight Normal            ctermbg=NONE',
            \ 'highlight LineNr            ctermbg=NONE',
            \ 'highlight SignifyLineAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifyLineDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifyLineChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignifySignAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifySignDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifySignChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignColumn        ctermbg=NONE',
            \ 'highlight CursorLine        ctermbg=NONE cterm=underline',
            \ 'highlight Folded            ctermbg=NONE cterm=bold',
            \ 'highlight FoldColumn        ctermbg=NONE cterm=bold',
            \ 'highlight NonText           ctermbg=NONE',
            \ 'highlight clear LineNr'
            \]

""" Airline """
let g:airline_powerline_fonts = 1
" let g:airline_theme="powerlineish"
let g:airline#extensions#tabline#enabled = 1
"let g:airline_section_warning = "%{airline#util#wrap(atplib#ProgressBar(),0)}%{airline#util#wrap(g:status_OutDir,0)}%{airline#util#wrap(airline#extensions#syntastic#get_warnings(),0)}%{airline#util#wrap(airline#extensions#whitespace#check(),0)}"
"let g:airline_section_warning = "%{airline#util#wrap(atplib#ProgressBar(),0)}%{airline#util#wrap(airline#extensions#syntastic#get_warnings(),0)}%{airline#util#wrap(airline#extensions#whitespace#check(),0)}"
Plug 'bling/vim-airline'

""" NerdTree """
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
Plug 'scrooloose/nerdtree'

Plug 'ryanoasis/vim-webdevicons'

""" Ack """
Plug 'rking/ag.vim'

Plug 'vim-scripts/ScrollColors'

""" Rainbow Parantheses """
let g:rainbow_active = 1
Plug 'luochen1990/rainbow'

" let g:rbpt_colorpairs = [
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['black',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]
"
" let g:rbpt_max = 16
"
" let g:rbpt_loadcmd_toggle = 0
" Plug 'kien/rainbow_parentheses.vim'

""" Recover """
Plug 'chrisbra/Recover.vim'

""" IndentLine (Indent Guides with Conceal) """
let g:indentLine_char = '»'
let g:indentLine_color_term = 239
" other lines: ┆ ¦ │
Plug 'Yggdroot/indentLine'

""" Repeat """
" Make actions of some plugins repeatable
Plug 'tpope/vim-repeat'

""" Auto close parantheses (repeatable)
let g:lexima_map_escape=''
Plug 'cohama/lexima.vim'

Plug 'tomtom/tcomment_vim'
vmap gb :TCommentBlock<cr>

""" Surround """
" Surround stuff with braces or XML tags or delete/replace
" ds* delete cs* replace ys* surround
" t as * selects an XML tag
function! DeleteBrackets()
    normal %%
    let c = getline(".")[col(".") - 1]
    execute 'normal ds' . c
endfunction

nnoremap dss :call DeleteBrackets()<CR>
Plug 'tpope/vim-surround'

""" TagBar """
nmap <F8> :TagbarToggle<CR>
Plug 'majutsushi/tagbar'

""" MatchTagAlways and matchit """
" This highlights enclosing/matching tags in HTML and XML
Plug 'Valloric/MatchTagAlways'

""" You Complete Me """
" disable <tab>, <s-tab> as it is used by UltiSnips, c-n and c-p work just fine
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1,
      \ 'c': 1
      \}
Plug 'Valloric/YouCompleteMe', { 'do': 'if [[ -n $(ldconfig -p \| grep libclang.so) ]]; then; ./install.sh --clang-completer --system-libclang; else; ./install.sh; fi' }

""" UltiSnips and Snippets """
" UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets = "<leader><tab>"
"let g:UltiSnipsDontReverseSearchPath="1"

Plug 'SirVer/ultisnips'
" Snippets are separated from the engine.
Plug 'honza/vim-snippets'

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
" Plug 'junegunn/fzf', { 'dir': '~/dotfiles/fzf', 'do': 'yes \| ./install' }
" List of buffers
function! BufList()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! BufOpen(e)
  execute 'buffer '. matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><c-?> :call fzf#run({
\   'source':      reverse(BufList()),
\   'sink':        function('BufOpen'),
\   'options':     '+m',
\   'tmux_height': '40%'
\ })<CR>

""" Signify """
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'
" Colors for Signify symbols are defined in CSApprox_hook_post

""" Ctrl + P """
let g:ctrlp_map = '<c-?>'
let g:ctrlp_cmd = 'CtrlP'
map <c-a-p> :CtrlPMixed<CR>
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
\ 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
\ 'file': '\.exe$\|\.so$\|\.dat$'
\ }
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" -g ""'
" let g:ctrlp_use_caching = 0
Plug 'kien/ctrlp.vim'

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
Plug 'FelikZ/ctrlp-py-matcher'


Plug 'rust-lang/rust.vim'
Plug 'phildawes/racer', { 'do': 'cargo build --release' }
let g:racer_cmd = "~/vim/plugged/racer/target/release/racer"
let $RUST_SRC_PATH="/home/gordin/projects/rust/src"

autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo








""" Language Plugins




""" Syntastic """
Plug 'scrooloose/syntastic'

Plug 'justmao945/vim-clang'

Plug 'suan/vim-instant-markdown'

""" Tern for Vim """
Plug 'marijnh/tern_for_vim', { 'do': 'npm install'}

""" Nim
Plug 'zah/nim.vim'

""" polyglot """
let b:LatexBox_loaded = 1 "Don't load LatexBox (we use latex-suite)
let g:coffee_make_options = '-b'
au BufRead,BufNewFile *.coffee set tabstop=8
au BufRead,BufNewFile *.coffee set shiftwidth=2
au BufRead,BufNewFile *.coffee set softtabstop=2
Plug 'sheerun/vim-polyglot'


let g:Tex_DefaultTargetFormat = 'pdf'
" let g:Tex_CompileRule_pdf = 'lualatex -shell-escape --interaction=nonstopmode --file-line-error-style $*'
let g:Tex_CompileRule_pdf = 'arara -v $*'
let g:Tex_UseMakefile = 0
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_SmartKeyQuote = 0
let g:Tex_ViewRule_ps = 'okular'
let g:Tex_ViewRule_pdf = 'okular'
let g:Tex_ViewRule_dvi = 'okular'

function! SyncTexForward()
  let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r").".pdf"
  let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
  exec execstr
  redraw!
endfunction

Plug 'git://git.code.sf.net/p/vim-latex/vim-latex'




call plug#end()






""" Leader """
let mapleader = ","
let maplocalleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

set spelllang=de_20,en          " german and english spellchecking
set nospell                     " disable spellchecking on startup


""" Folding """
set foldlevelstart=0
set foldmethod=indent           " Fold automatically based on indentation level

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

""" Looks """
" set background=dark             " Tell vim that our background is dark
try
    colorscheme gotham256             " Select cholorscheme
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
endtry
" colorscheme base16-atelierforest             " Select cholorscheme
set noshowmode                  " Hide the mode text as airline already shows this
set nolazyredraw

set number                      " Show line numbers
set cursorline                  " Highlight the line with the cursor
set mousehide                   " Hide the mouse cursor while typing (works only in gvim?)
set scrolloff=10                " Always have 10 lines at the top/bottom above/below cursor

set showmatch                   " Highlight matching brackets when a pair is closed

"" Listchars ""
set list                        " enable listchars
set listchars=""                " Reset the listchars
set listchars=tab:»\            " a tab should display as "»"
set listchars+=trail:…          " show trailing spaces as dots
set listchars+=eol:¬            " show line break
set listchars+=extends:>        " The character to show in the last column when wrap is off and the
                                " line continues beyond the right of the screen
set listchars+=precedes:<       " The character to show in the last column when wrap is off and the
                                " line continues beyond the right of the screen

""" History, Backup, undo """
set history=10000

set backup                      " Enable backups ...
set backupdir=~/.vim/tmp/backup// " set directory for backups

" Don't backup files in temp directories
set backupskip=/tmp/*,/private/tmp/*,~/.vim/tmp/,~/tmp/"

if has('persistent_undo')
    set undofile                  " Save undo history to file
    set undodir=~/.vim/tmp/undo// " undo files in folder
    set undolevels=100000          " Maximum number of undos
    set undoreload=100000          " Save complete files for undo on reload if it has less lines
endif

set directory=~/.vim/tmp/swap//   " set directory for swap files


""" Behaviour """
set smartindent         " Do autoindenting based on systax
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set matchpairs+=<:>     " Match, to be used with %

set mouse=a             " Automatically enable mouse usage
set hidden              " allow to switch buffers without saving

set wildmode=full,full  " Command <Tab> completion, Show all matches, cycle through with <tab>
set wildchar=<tab>      " Make sure Tab starts wildmode
set wildignorecase      " ignore case in wildmode
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

set timeout             " Enable timeouts on mappings and key codes
set timeoutlen=300      " Set timeout for mappings
set nottimeout
au VimEnter * set nottimeout " Do this becaus something keep setting this...

set splitbelow          " open vertical splits below current buffer
set splitright          " open horizontal splits right of current buffer

set gdefault            " substitutions have the g (all matches) flag by default. Add g to turn off

set clipboard^=unnamed   " makes middle-click clipboard the standard register for yanking/pasting

" go down or up 1 visual line on wrapped lines instead of line of file
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Allows to select beyond end of lines in block selection mode
set virtualedit=block

"" Searching ""
set ignorecase          " Ignore case while searching
set smartcase           " Be case sensitive when capital letters are used
set hlsearch

autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

" Toggle search-highlights with <leader>/
" nmap <silent> <leader>/ :set invhlsearch<CR>

" Use dp and do only on selected lines
vnoremap dp :diffput<CR>:diffupdate<CR>
vnoremap do :diffget<CR>:diffupdate<CR>

" fast Diffoff
nnoremap <leader>D :diffoff!<cr>

" Diff current buffer against currently saved version of the file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis


""" Tabs, Spaces, Wrapping """
set tabstop=4           " <tab> is 8 spaces long
set shiftwidth=4        " shift text by 4 spaces with autoindent or << / >>
set softtabstop=4       " Use shiftwidth als visible width of tabs
set expandtab           " expands <tab> to spaces
set wrap                " enables wrapping text at the end of lines
set formatoptions+=qrn12        " Set formatting options
"set textwidth=99        " maximum with of a line is 85
"set colorcolumn=+1

""" Abbreviations """
iabbrev :ldis: ಠ_ಠ
iabbrev :shrug: ¯\_(ツ)_/¯
iabbrev :flip: (╯°□°)╯︵ ┻━┻
iabbrev :aflip: (ﾉಥ益ಥ）ﾉ ┻━┻
iabbrev :patience: ┬─┬ ノ(゜-゜ノ)
iabbrev :zwnj: ‌
iabbrev :check: ✓

""" Autocommands """
" When vimrc is edited, reload it
autocmd! bufwritepost .nvimrc source ~/.vimrc
autocmd! bufwritepost .nvimrc :CSApprox

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

"Jump to last cursor position when opening a file
autocmd BufReadPost * call s:SetCursorPosition()
function! s:SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

""" Filetype specific stuff """

" Make sure all mardown files have the correct filetype set
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set filetype=markdown

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json set ft=javascript

" Treat gradle files like gradle files…
au BufNewFile,BufRead *.gradle set ft=gradle

" detect ssh config file in different folder
au BufNewFile,BufRead */ssh/config  setf sshconfig

""" Convenience mappings """

" Remove trailing whitespace
map <leader>W  :%s/\s\+$//<cr>:let @/=''<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Substitute
nnoremap <leader>S :%s/
nnoremap <leader>f :call SyncTexForward()<CR>

" Faster Esc
inoremap jk <esc>
inoremap kj <esc>

nnoremap <leader>T :!sdcv -u "English Thesaurus" <cword><cr>

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! w !sudo tee % >/dev/null

" cd to the directory containing the file in the buffer
nmap <silent> <leader>. :lcd %:h<CR>

" don't select the newline with $ in visual mode
vnoremap $ $h

" yank till start/end of line with H/L instead of tob/bottom of screen
nnoremap yH y^
nnoremap yL y$

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Edit vimrc and expand symlinks to the actual folder
nnoremap <leader>vimrc :e <C-r>=resolve(expand("~/.nvimrc"))<CR><CR>

" Easier movement between splits
nnoremap <a-j> <C-W>j
nnoremap <a-k> <C-W>k
nnoremap <a-l> <C-W>l
nnoremap <a-h> <C-W>h
tnoremap <a-h> <C-\><C-n><C-w>h
tnoremap <a-j> <C-\><C-n><C-w>j
tnoremap <a-k> <C-\><C-n><C-w>k
tnoremap <a-l> <C-\><C-n><C-w>l

tnoremap <Esc><Esc> <C-\><C-n>

" Keep cursor at the same position when joining lines
nnoremap J mzJ`z

" make K do the opposite of J (Split a line)
nnoremap K a<CR><esc>k$

" Get directory of current file in command line mode
cnoremap <leader>. <C-R>=expand('%:h').'/'<cr>

" Open directory of current file
nmap <leader>e. :e %:h<CR>

"Stop that stupid window from popping up:
map q: :q

"Don't copy stuff deleted with x
noremap x "_x

nnoremap H :tabprevious<cr>
nnoremap L :tabnext<cr>

nnoremap <space> za

set pastetoggle=<F12>     " Toggle paste with <F12>


" vp doesn't replace paste buffer
" function! RestoreRegister()
"   let @" = s:restore_reg
"   return ''
" endfunction
" function! s:Repl()
"   let s:restore_reg = @"
"   return "p@=RestoreRegister()\<cr>"
" endfunction
" vmap <silent> <expr> p <sid>Repl()


noremap <silent> <leader>mk :!latexmk %:t:r -shell-escape -lualatex<CR><CR>
