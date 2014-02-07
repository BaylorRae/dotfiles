" colorscheme xoria256

" Powerline options
set guifont=Monaco\ for\ Powerline:h18
set linespace=8
set encoding=utf-8
let g:Powerline_symbols = 'fancy'
set noshowmode

set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar

" force block cursor and disable cursor blink
set gcr=a-n-v-c:block-Cursor
set gcr=a-n-v-c:blinkon0

" change cursor line color
hi CursorLineNr term=bold ctermfg=11 gui=bold guifg=lightyellow
