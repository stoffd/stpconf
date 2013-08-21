
filetype plugin indent on               "включаем автообнаружение типа файла
set nu
set history=50                          "сохранять 50 строк в истории командной строки
set ruler                               "постоянно показывать позицию курсора
set incsearch                           "показывать первое совпадение при наборе шаблона
"set nohlsearch                          "подсветка найденного
set hlsearch                          "подсветка найденного


set mouse=a                             "используем мышку
set autoindent                          "включаем умные отступы
set smartindent
set ai                                  "при начале новой строки, отступ копируется из предыдущей
"set ignorecase                          "игнорируем регистр символов при поиске
set background=dark                     "фон терминала - темный
set ttyfast                             "коннект с терминалом быстрый
set showmatch                           "показываем открывающие и закрывающие скобки
set rulerformat=%(%l,%c\ %p%%%)         "формат строки состояния строка х столбец, сколько прочитано файла в %
"set wrap                                "не разрывать строку при подходе к краю экрана
set linebreak                           "переносы между видимыми на экране строками только между словами
set tabstop=4                           "размер табуляции
set shiftwidth=4                        "число пробелов, используемых при автоотступе
set t_Co=256                            "включаем поддержку 256 цветов
set wildmenu                            "красивое автодополнение
set autowrite                           "автоматом записывать изменения в файл при переходе к другому файлу
set encoding=utf8                       "кодировка по дефолту
set termencoding=utf8                   "Кодировка вывода на терминал
set fileencodings=utf8,cp1251,koi8r     "Возможные кодировки файлов (автоматическая перекодировка)
set showcmd showmode                    "показывать незавершенные команды и текущий режим
set splitbelow                          "новое окно появляется снизу
"set autochdir                           "текущий каталог всегда совпадает с содержимым активного окна
set tpm=100                             "максимальное количество открытых табов
set dir=~/.vim/swapfiles                "каталог для сохранения своп-файлов
set ssop+=resize                        "сохраняем в сессии размер окон Vim'а
set listchars=tab:→→,trail:⋅

"-------------------------------------------------------------------------------------

colorscheme baycomb                     "цветовая схема для терминала
syntax on                               "включаем подсветку синтаксиса

if has ("gui_running")
    "убираем меню и тулбар
    "set guioptions-=m
    set guioptions-=T
    "убираем скроллбары
    set guioptions-=r
    set guioptions-=l
    "используем консольные диалоги вместо графических
    set guioptions+=c
    "антиалиасинг для шревтоф
    set antialias
    "прячем курсор
    set mousehide
    "Так не выводятся ненужные escape последовательности в :shell
    set noguipty
    "подсветка текущей строки
    set cursorline
    "font
    set guifont=DroidSansMonoSlashed
    "используем эту цветовую схему
    colorscheme darkspectrum
endif


"---------------------------------------------------------------------------------------------------
"----------------------INCLUDING FTPLUGIN------------
"-----------------------------------------------------
autocmd FileType text setlocal textwidth=80 "устанавливаем ширину в 80 знаков для текстовых файлов


autocmd BufNewFile,BufRead *.cpp source ~/.vim/ftplugin/cpp.vim
autocmd BufNewFile,BufRead *.hpp source ~/.vim/ftplugin/cpp.vim
autocmd BufNewFile,BufRead *.c source ~/.vim/ftplugin/cpp.vim
autocmd BufNewFile,BufRead *.h source ~/.vim/ftplugin/cpp.vim

"autocmd BufNewFile,BufRead *.java source ~/.vim/ftplugin/java.vim


if has("autocmd")
"	autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif


"-----------------------------------------------------------------------------------
set completeopt=menu



" по звездочке не прыгать на следующее найденное, а просто подсветить
nnoremap <Asterisk> *N
" выключить подсветку: повесить на горячую клавишу Ctrl-F8
nnoremap <C-F8> :nohlsearch<CR>
" в визуальном режиме по команде * подсвечивать выделение
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>
 " после сдвига выделеный блок остается выделеным
"vnoremap < vnoremap > >gv

" Auto adding 
map <C-g> g<C-g>
"imap <C-Space> <C-N>
imap <S-Space> <C-x><C-u>
" Открытие\закрытие новой вкладки
imap <C-t>t <Esc>:tabnew<CR>a
nmap <C-t>t :tabnew<CR>

" показать\спрятать номера строк
imap <C-c>n <Esc>:set<Space>nu!<CR>a
nmap <C-c>n :set<Space>nu!<CR>
  
" Запуск проверки правописания
menu Spl.next ]s
menu Spl.prev [s
menu Spl.word_good zg
menu Spl.word_wrong zw
menu Spl.word_ignore zG
imap <C-c>s <Esc>:setlocal spell spelllang=ru,en<CR>a
nmap <C-c>s :setlocal spell spelllang=ru,en<CR>
imap <C-c>ss <Esc>:setlocal spell spelllang=<CR>a
nmap <C-c>ss :setlocal spell spelllang=<CR>
map  <C-c>sm :emenu Spl.<TAB>
