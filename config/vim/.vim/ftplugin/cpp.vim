" обновление ctags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ./src/*<CR>
let OmniCpp_ShowPrototypeInAbbr = 1 "functions prototypes in autoAdding 
let OmniCpp_MayCompleteScope = 1 " auto adding after scopes
"--hide autoAdding element info after after this element inserted
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
