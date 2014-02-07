set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar

" force block cursor and disable cursor blink
set gcr=a-n-v-c:block-Cursor
set gcr=a-n-v-c:blinkon0

" change cursor line color
hi CursorLineNr term=bold ctermfg=11 gui=bold guifg=lightyellow
