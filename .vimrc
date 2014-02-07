" autoload bundles
call pathogen#infect()

set shell=/bin/sh

" let rega= @a
" let t_ti= &t_ti
" let t_te= &t_te
" let rs  = &rs
" set t_ti= t_te= nors

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
" set hidden

" Keep more context when scrolling off the end of a buffer
" set scrolloff=3

" force block cursor and disable cursor blink
set gcr=a-n-v-c:block-Cursor
set gcr=a-n-v-c:blinkon0

" use a different font
set guifont=Monaco:h18
set encoding=utf-8

" line numbers
set number

" move cursor by display lines
noremap j gj
noremap k gk

" don't wait for escape sequence
set ttimeoutlen=0

" allow backspace over everything in insert mode
set backspace=indent,eol,start

" change tab widths
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " use spaces instead of tabs
set autoindent

" use comma as leader instead of backslash
let mapleader=","

" Refresh the current list of files
map <leader>f :CommandTFlush<cr>

" CommandT: ignore images
set wildignore+=*/doc/*,app/assets/images,*.pdf,*.jpg,*.png,*.gif,*.tif,*.psd

if filereadable("composer.phar")
  set wildignore+=vendor
endif

" CommandT: ignore tmp files
set wildignore+=*/tmp/*

" highlight current line
set cursorline

" use two lines in the prompt
set cmdheight=2

" turn on syntax highlighting
syntax on

" GRB: highlighting search"
set hlsearch

" searching
set incsearch
set ignorecase
set smartcase
set winwidth=110

" GRB: set the color scheme
:set t_Co=256 " 256 colors
:set background=dark
colorscheme grb256


" NERDTree toggle
nmap <C-b> :NERDTreeToggle<cr>

" NERDTree options
let g:NERDTreeWinSize = 36

" When the terminal has colors, enable syntax+search highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  hi CursorLine guifg=#f6f3e8     guibg=#121212       gui=NONE      ctermfg=NONE        ctermbg=234        cterm=NONE
endif

if has("gui_running")
  set guioptions-=T
endif

if g:colors_name == "solarized"
  hi clear Visual
  hi Visual ctermbg=15 guibg=DarkGrey
endif

if $ITERM_PROFILE == "Teerb"
  colorscheme xoria256
  set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim
endif

" Quickly insert hash rocket
imap <c-L> <space>=><space>

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" GRB: turn selected text into a variable
function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction
vnoremap <leader>rv :call ExtractVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GRB: INLINE VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    :normal 2daW
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
    :normal "bd$
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/\<' . @a . '\>/' . @b
    :let @a = l:tmp_a
    :let @b = l:tmp_b
endfunction
nnoremap <leader>ri :call InlineVariable()<cr>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" GRB: clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" GRB: Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" *.md is read as a markdown file
au BufNewFile,BufRead *.md set filetype=markdown

" *.coffee is read as a coffeescript file
au BufNewFile,BufRead *.coffee set filetype=coffee

" *.md has a default text width of 80 characters
au BufNewFile,BufRead *.md set tw=80

" *.hbs is a handlebars file
au BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=handlebars

set numberwidth=5

" Open routes.rb at the top of the screen
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>ga :CommandTFlush<cr>\|:CommandT app/assets<cr>

" Make sure the status line is visible
:set laststatus=2

" Better tab navigation
nnoremap th  :tabprev<CR>
nnoremap tl  :tabnext<CR>
nnoremap tn  :tabnew<CR>

" based on Gary Bernhardt's status line
set statusline=
set statusline+=%<%f " path/to/file
set statusline+=\ (%{&ft}) " (file_type)
set statusline+=%m " have changes been made?
set statusline+=%= " right aligned
set statusline+=(%l,%c) " (line,col)
set statusline+=%-19([%P]%) " percentage through the file

" GRB: store temporary files in a central spot
" no more *.swp files!
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w

    " Clear the screen
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!bundle exec cucumber " . a:filename
    elseif match(a:filename, '\.php$') != -1
        exec ":!./vendor/bin/phpunit --colors " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif


    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.php\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

map <leader>a :call RunTestFile()<cr>
map <leader>w :w\|:!bundle exec cucumber --profile wip<cr>

" shortcut to text formatting
map Q gq

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Align piped tables when a pipe is inserted <https://gist.github.com/287147>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
 :normal! dd
 :exec '?^\s*it\>'
 :normal! P
 :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
 :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>
