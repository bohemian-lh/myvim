if has("syntax")
  syntax on
  syntax enable
endif

"1.基本设置"
"==================="
set matchtime=20	"match highlight time
set ignorecase"忽略大小写"
set infercase"忽略大小写"
set number "显示行号"
set rnu    "相对行号"
set ruler"显示当前光标位置"
set cursorline
set cursorcolumn
set autoread"文件在Vim之外修改过，自动重新读入"
set autowrite"设置自动保存内容"
set autochdir"当前目录随着被编辑文件的改变而改变"
set mouse=a"开启鼠标支持"
map 9 $"通过9跳转到行末尾,0默认跳转到行首"
set wildmenu "命令行模式下自动补全
set wildmode=longest:full,full
set showcmd
map <F2> :noh 
map <silent>  <C-A>  gg v G "Ctrl-A 选中所有内容"
filetype on "启动文件类型检查"
filetype plugin on "运行vim加载文件类型插件"

"==================="
"2.程序开发相关的设置"
"==================="
"(1)使用%来选择语句块，然后使用快捷键zf来折叠"
set foldmethod=marker
"(2)注释：选中文本后，输入;c即可注释，输入;u 即可取消注释"
vmap <silent>fcc :s/^/\/\//<CR>:noh<CR>
vmap <silent>fcu :s/\/\///<CR>:noh<CR>
nmap <silent>fcc <s-v>:s/^/\/\//<CR>:noh<CR>
nmap <silent>fcu <s-v>:s/\/\///<CR>:noh<CR>
"(3) 编译和运行程序的快捷键"
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
	exec '!g++ % -o %<'
	exec '!time ./%<'
	exec '!date \+\%Y\-\%m\-\%d\-\-\-\-\%H:\%M\:\%S'
    elseif &filetype == 'cc' || &filetype == 'cpp'
	exec '!g++ % -o %<'
	exec '!time ./%<'
	exec '!date \+\%Y\-\%m\-\%d\-\-\-\-\%H:\%M\:\%S'
    elseif &filetype == 'python'
	exec '!time python %<'
	exec '!date \+\%Y\-\%m\-\%d\-\-\-\-\%H:\%M\:\%S'
    elseif &filetype == 'sh'
	exec '!time bash %<'
	exec '!date \+\%Y\-\%m\-\%d\-\-\-\-\%H:\%M\:\%S'
    endif
endfunc

func Run()
    exec '!time ./%<'
    exec '!date \+\%Y\-\%m\-\%d\-\-\-\-\%H:\%M\:\%S'
endfunc

map <F5> :call CompileRunGcc()<CR>
map <F6> :call Run()<CR>
map <silent>  <C-F5> :make %:r <CR>:!./%:r<CR>  "Ctrl+F5: 执行makefile文件"
map <silent>  \rr :!gcc  -Wall -g  %  -lm -o  %:r<CR> :!./%:r<CR>"\rr: 编译并运行当前文件的对应程序"
map  <silent>  \rc :!gcc  -Wall -g -c % <CR>"\rc:编译当前文件"
"(4)源文件和头文件之间快速切换"
nmap ,a :find %:t:r. ",a: 切换到任意文件。需要手动输入文件的后缀"
nmap ,c :find %:t:r.c<cr> ",c: 切换到同名c语言的源文件"
nmap ,C :tabf %:t:r.cpp<cr> ",C: 切换到同名c++的源文件,以tabpage形式打开"
nmap ,h :find %:t:r.h<cr>",h 切换到当前文件对于的头文件"
"(5)其他"
set pastetoggle=<F11> "F11来支持切换paste和nopaste状态。"

"============"
"3. 多窗口操作"
"============"
map <C-l> <C-W>l "C-l 移动到右侧窗口"
map <C-h> <C-W>h "C-h 移动到左侧窗口"
map <C-j> <C-W>j   "C-j 移动到下方窗口"
map <C-k> <C-W>k "C-k 移动到上方窗口"

"============"
"4. tabpages切换"
"============"
"map < :tabpre<CR>
"map > :tabnex<CR>

"============="
"5. 设置缩进"
"============="
set cindent "c/c++自动缩进"
set smartindent
set autoindent"参考上一行的缩进方式进行自动缩进"
filetype indent on "根据文件类型进行缩进"
set shiftwidth=4
set softtabstop=-1 "4 character as a tab"
set shiftwidth=4
set smarttab

"================="
"6. 当前文件内搜索选项"
"================="
set hlsearch "开启搜索结果的高亮显示"
set incsearch "边输入边搜索(实时搜索)"

"=============="
"7. 会话功能"
"=============="
""autocmd VimLeave * :mksession! ~/.last.vim "保存当前会话"
""autocmd VimEnter * :so ~/.last.vim "加载会话"

"=========================="
"8.不要交换文件和备份文件，减少冲突"
"=========================="
set noswapfile
set nobackup
set nowritebackup

"============="
"9. 查找和替换文本"
"============="
nmap ;s :%s/<C-R>=expand("<cword>")<CR>/
nmap ;ss :.s/<C-R>=expand("<cword>")<CR>/
nmap ;g :vimgrep <C-R>=expand("<cword>")<CR>

"========================"
" 10.快捷文本输入"
"========================"
map <silent>  \d a<C-R>=strftime("%Y/%m/%d %A")<CR>  "快捷输入日期"
map <silent>  \t a<C-R>=strftime("%Y/%m/%d %H:%M:%S")<CR>"快捷输入时间"
map <silent>   ,d :split ~/Dropbox/Doc/ <CR>
iab --l  --------------------
iab ==l  ====================

"========================"
"11.txt文件按照wiki语法高亮"
"========================"
 autocmd BufNewFile *.txt set ft=confluencewiki
 autocmd BufEnter *.txt set ft=confluencewiki

 "======================"
 "12.设置文件编码，解决中文乱码问题"
 "======================"
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
 if has("multi_byte")
    set fileencodings=utf-8,ucs-bom,cp936,cp1250,big5,euc-jp,euc-kr,latin1
 else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
 endif

 "==================="
 "13. 对gvim 的设置"
 "=================="
 "if has("gui_running")
 "   colorscheme  morning
 "   set guifont=Monaco:h13
 "   set guioptions=mr "只显示菜单和右侧滚动条"
 "endif


"let g:rehash256=1
set t_Co=256
color molokai
let g:molokai_original=1

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif



"shortkep config
"map <Leader>a <ESC>ggvG
map <F4> <ESC>:w<CR>
map <F3> <ESC>:wq<CR>
"复制&剪切 专用寄存器
onoremap y "yy
noremap yy "yyy
onoremap d "dd
noremap dd "ddd
noremap dp "dp
noremap yp "yp

"快速设置标记，删除标记
func! Delmark()
    exec 'delmark'
endfunc
nnoremap dm :delmarks<space>
inoremap jk <ESC>
inoremap jj <ESC>^i
inoremap kk <ESC><End>a
inoremap [ []<ESC>i
inoremap ( ()<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
"自动补全先浏览在选择
"inoremap <c-n> <c-n><c-p>
"粘贴不替换剪切板
xnoremap p pgvy
"左右箭头切换buffer
noremap <silent> <Left> :bp<CR>
noremap <silent> <Right> :bn<CR>
"inoremap < <><ESC>i
"inoremap ; ;<CR> 
nmap <Tab> i<Tab><Esc>
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"nmap <C-/> 0i//jk<End>
""

"The function of skipping ')' when cursor at the end of (),and replace <c-n> in auto-complete feature with <tab>
func SkipPair()
 "   if getline('.')[col('.')] - 1] == ')'|| getline('.')[col('.') - 1] == ']'||getline('.')[col('.') - 1] == '"'||getline('.')[col('.') - 1] == '''||getline('.')[col('.') - 1] == '}'
    if pumvisible()
	call feedkeys(pumvisible() ? "\<c-n>" : "\<TAB>", 'n')
	return ''
    endif
    if matchstr(getline('.'), '\%' . col('.') . 'c.') == ")" || matchstr(getline('.'), '\%' . col('.') . 'c.') == ']' || matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' || matchstr(getline('.'), '\%' . col('.') . 'c.') == '"' || matchstr(getline('.'), '\%' . col('.') . 'c.') == "'" || matchstr(getline('.'), '\%' . col('.') . 'c.') == ">"  
	return "\<ESC>la"
    else
	return "\t"
    endif
endfunc
"Bind <tab> to the function of SkipPair()
:inoremap <tab> <c-r>=SkipPair()<CR>



"enter the next line when cursor in {}
func EnterMiddle()
    if pumvisible()
	call feedkeys("\<C-Y>")
	return ""
    endif
    if matchstr(getline('.'), '\%' . col('.') . 'c.') == "}"  
	return "\<CR>\<CR>\<ESC>k\<End>i"
    else
	return "\<CR>"
    endif
endfunc
"Bind <CR> to the function of EnterMiddle()
:inoremap <CR> <c-r>=EnterMiddle()<CR>
    
"<Tab> replace <C-n>  under the complete window.
"func Tab()
"    call feedkeys(pumvisible() ? "\<c-n>" : "\<TAB>", 'n')
"    return ''
"endfunc
":inoremap <expr><tab> Tab()


"configures Plug-in Manager: Vundle

set nocompatible              " be iMproved,
filetype off                  " required
                                          
"set the runtime path to include Vundle and"configures vim-airline
set rtp+=~/.vim/bundle/Vundle.vim           
set rtp+=/home/harriszh/.fzf/
call vundle#begin()
"alternatively, pass a path where Vundle sh
"call vundle#begin('~/some/path/here')
                                          
"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
                                          
"The following are examples of different fo
"Keep Plugin commands between vundle#begin/
"plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"plugin from http://vim-scripts.org/vim/scr
"Plugin 'L9'
"Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"git repos on your local machine (i.e. when
"Plugin 'file:///home/gmarik/path/to/plugin'
"The sparkup vim script is in a subdirector
"Pass the path to set the runtimepath prope
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Install L9 and avoid a Naming conflict if 
"different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}
                                          
"Install air-vimline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/Vim-airline-themes'

"Install easymotion
Plugin 'easymotion/vim-easymotion'

"Install fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

"Install YCM
Plugin 'Valloric/YouCompleteMe'

"Install syntastic
Plugin 'scrooloose/syntastic'

"All of your Plugins must be added before t
call vundle#end()            " required
filetype plugin indent on    " required
"To ignore plugin indent changes, instead u
"filetype plugin on
"
"Brief help
"PluginList       - lists configured plugi
"PluginInstall    - installs plugins; appe
"PluginSearch foo - searches for foo; appe
"PluginClean      - confirms removal of un
"
"see :h vundle for more details or wiki for
"Put your non-Plugin stuff after this line

"configures vim-airline

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2

"configures easy-motion
let g:EasyMotion_smartcase=1
let mapleader = ' '
let g:mapleader = ' '
" <Leader>f{char} to move to {char}{{{
map ff <Plug>(easymotion-s)

" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)

"multi match
nmap fs <Plug>(easymotion-sn)
nmap s <Plug>(easymotion-s2)
" Move to line
map fl <Plug>(easymotion-bd-jk)
nmap fl <Plug>(easymotion-overwin-line)

" Move to word
map  fw <Plug>(easymotion-bd-w)
nmap fw <Plug>(easymotion-overwin-w)
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())"}}}

"move to off-screen locations ,This feature is inspired by and based on vim-sneak. So a better approach to off-screen situation is to use '/' to match a string.`
"nmap <Leader>; <Plug>(easymotion-next)
"nmap <Leader>, <Plug>(easymotion-prev)

" fzf
" fzf use rg search config
"let g:fzf_layout = { 'down': '~70%' }
" fzf vim
nnoremap  <silent> frg :Rg<CR>
nnoremap fb :Buffers<CR>
nnoremap <C-p> :Files<CR>

"confiures ycm
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_complete_in_comments = 1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
let g:ycm_key_list_stop_completion = ['<c-y>']
" 解决tab和自定义skip函数冲突问题
let g:ycm_key_list_select_completion = []

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ }
"Configures syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" 设置错误符号
let g:syntastic_error_symbol='✗'
" 设置警告符号
let g:syntastic_warning_symbol='⚠'
" 是否在打开文件时检查
let g:syntastic_check_on_open=0
" 是否在保存文件后检查
let g:syntastic_check_on_wq=1
" 设置检查类型
let g:syntastic_cpp_cppchecker = ['cpp','cc']

"let g:syntastic_debug=1
" 自动更新底部错误信息
let g:syntastic_always_populate_loc_list = 1
" 自动跳转到第一个问题
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1

