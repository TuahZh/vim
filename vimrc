""""""""""""""""""""""""""""""""""""""""""""""
"Generated Time: 
"   Sun Jul  8 15:52:02 CST 2012
"Author:
"   ZHANG GaoYuan
"Email:
"   zgy0106@gmail.com
""""""""""""""""""""""""""""""""""""""""""""""
" test shell
if $SHELL =~ "fish"
	set shell=/bin/sh
endif

set history=500  "历史记录最大值

let s:extfname = expand("%:e")
if s:extfname ==? "f90"
let fortran_free_source=1
unlet! fortran_fixed_source
else
let fortran_fixed_source=1
unlet! fortran_free_source
endif

autocmd BufRead,BufNewFile * exec 'call Selecttype()'

func! Selecttype()

	"python:

	if &filetype == 'python'

	autocmd FileType python setlocal et sta sw=4 sts=4

	autocmd FileType python setlocal foldmethod=indent
	set expandtab
	"默认展开所有代码
	"set indentlevel=99

"autocmd BufWritePost *.py call Flake8()

	let g:flake8_ignore="E501,W293,W404"

	endif

	"fortran

	if &filetype == 'fortran'

	"        let fortran_free_source=1
	let fortran_more_precise=1
	let fortran_do_enddo=1
	"        unlet! fortran_fixed_source

	" 自动格式化
	set formatoptions=tcrqn

	" 继承前一行的缩进方式，特别适用于多行注释
	set autoindent

	" 为C程序提供自动缩进
	set smartindent

	" 使用C样式的缩进
	set cindent

	" 制表符为2
	set tabstop=4

	" 统一缩进为2
	set softtabstop=4
	set shiftwidth=4

	" 要用空格代替制表符
	set expandtab

	" 不要换行
	set nowrap

	" 在行和段开始处使用制表符
	"        set smarttab

	"去掉固定格式每行开头的红色填充
	"        let fortran_have_tabs=1

	"允许Fortran代码折叠
	let fortran_fold=1

	"设置代码折叠的方式，这样每个program、module、subroutine、function都可以折叠了

	set foldmethod=syntax

	"如果前面启用了代码折叠，那么文件一打开代码全部是折叠的，需再按“zO”打开全部折叠的代码
	"如果想在文件打开后所有折叠都自动展开，请加入以下配置
	set foldlevelstart=99

	"设置代码折叠符号（行号左侧），可要可不要，看自己喜欢了
	set foldcolumn=4

	endif

	endfunc

	syntax on  "语法高亮

	"重新加载 .vimrc
	map <silent> <leader>rr :source ~/.vimrc<cr>
	"编辑 .vimrc
	map <silent> <leader>ee :e ~/.vimrc<cr>
	" .vimrc改变后快速加载
	"autocmd! bufwritepost .vimrc source ~/.vimrc
	"
	""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"显示相关
	"
	""""""""""""""""""""""""""""""""""""""""""""""""

	"set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  

	"winpos 5 5          " 设定窗口位置  

	"set lines=40 columns=155    " 设定窗口大小  

	set nu              " 显示行号

	"set go=             " 不要图形按钮  

	"color asmanian2     " 设置背景主题  

	set guifont=Courier_New:h10:cANSI   " 设置字体

	autocmd InsertLeave * se nocul  " 用下划线表示当前行  

	autocmd InsertEnter * se cul    " 用下划线表示当前行

	set ruler           " 显示标尺  

	set showcmd         " 输入的命令显示出来，看的清楚些

	set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  

	set hid  "隐藏放弃的文件

	"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  

	set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离

	"set so=7

	"set novisualbell    " 不要闪烁(不明白)

	set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容

	set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)

	set foldenable      " 允许折叠  

	set foldmethod=manual   " 手动折叠 zc zo zC zO

	"set background=dark "背景使用黑色?

	set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限 `

	" 显示中文帮助

	if version >= 603

	set helplang=cn

	set encoding=utf-8

	endif

	" 设置配色方案

"	colorscheme blackdust

	"字体 

	"if (has("gui_running")) 

	"   set guifont=Bitstream\ Vera\ Sans\ Mono\ 10 

	"endif
	set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

	set termencoding=utf-8

	set encoding=utf-8

	set fileencodings=ucs-bom,utf-8,cp936

	set fileencoding=utf-8

	"""""""""""""""""""""""""""""""""""""""""""""
	"
	"新文件开头
	"
	"""""""""""""""""""""""""""""""""""""""""""""

	"新建.c, .h, ,sh, .java, .py, .f90 自动插入文件头
	autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.f90,*.py exec ":call SetTitle()"

	"定义函数SetTitle，自动插入文件头 

func! SetTitle()

	"如果.sh, .py

	if &filetype == 'sh' || &filetype == 'python'

	call setline(1,"\#########################################################################")

	call append(line("."), "\# File Name: ".expand("%"))

	call append(line(".")+1, "\# Author: ZHANG, GaoYuan")

	call append(line(".")+2, "\# mail: zgy0106@gmail.com")

	call append(line(".")+3, "\# Created Time: ".strftime("%c"    ))

	call append(line(".")+4, "\#########################################################################")

	call append(line(".")+5, "\#description")

	call append(line(".")+6, "")

	"如果.f90

	elseif &filetype == 'fortran'

	call setline(1,"\!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

	call append(line("."), "\! File Name: ".expand("%"))

	call append(line(".")+1, "\! Author: ZHANG, GaoYuan")

	call append(line(".")+2, "\! mail: zgy0106@gmail.com")

	call append(line(".")+3, "\! Created Time: ".strftime("%c"    ))

	call append(line(".")+4, "\!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

	call append(line(".")+5, "\!description")

	call append(line(".")+6, "")

	else

	call setline(1, "/*************************************************************************") 

	call append(line("."), "    > File Name: ".expand("%")) 

	call append(line(".")+1, "    > Author: ZHANG, GaoYuan") 

	call append(line(".")+2, "    > Mail: zgy0106@gmail.com ") 

	call append(line(".")+3, "    > Created Time: ".strftime("%c")) 

	call append(line(".")+4, " ************************************************************************/") 

	call append(line(".")+5, "")

	endif

	if &filetype == 'cpp'

	call append(line(".")+6, "#include<iostream>")

	call append(line(".")+7, "using namespace std;")

	call append(line(".")+8, "")

	endif

	if &filetype == 'c'

	call append(line(".")+6, "#include<stdio.h>")

	call append(line(".")+7, "")

	endif

	if &filetype == 'sh'

	call append(line(".")+7, "\#!/bin/bash")

	call append(line(".")+8, "")

	endif

	if &filetype == 'python'

	call append(line(".")+7, "\#!/bin/env python")

	call append(line(".")+8, "")

	call append(line(".")+9, "from __future__ import division")

	call append(line(".")+10, "from pylab import *")

	call append(line(".")+11, "")

	endif

	"新建文件后，自动定位到文件末尾

	autocmd BufNewFile * normal G

	endfunc

	"""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"快捷键
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""

	"nmap <leader>w :w!<cr>

	"nmap <leader>f :find<cr>

	map <C-A> ggVGY

	map! <C-A> <Esc>ggVGY

	map <F12> gg=G

	" 选中状态下 Ctrl+c 复制

	vmap <C-c> "+y

	"去空行  

	nnoremap <F2> :g/^\s*$/d<CR> 

	"比较文件  

	"nnoremap <C-F2> :vert diffsplit

	"新建标签  

	"map <M-F2> :tabnew<CR>

	"列出当前目录文件  

	map <F3> :tabnew .<CR>

	"打开树状文件目录  

	map <C-F3> \be  

	"C，C++ 按F5编译运行

	"map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()

	exec "w"

	if &filetype == 'c'

	exec "!g++ % -o %<"

	exec "! ./%<"

	elseif &filetype == 'cpp'

	exec "!g++ % -o %<"

	exec "! ./%<"

	elseif &filetype == 'java' 

	exec "!javac %" 

	exec "!java %<"

	elseif &filetype == 'sh'

	:!./%

	endif

	endfunc

	"C,C++的调试

	map <F8> :call Rungdb()<CR>

func! Rungdb()

	exec "w"

	exec "!g++ % -g -o %<"

	exec "!gdb ./%<"

	endfunc

	" quickfix模式

	autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>


	"""""""""""""""""""""""""""""""""""""""""""""""""
	"
	"其他设置
	"
	"""""""""""""""""""""""""""""""""""""""""""""""""

	" 设置当文件被改动时自动载入

	set autoread

	"代码补全 

	set completeopt=preview,menu

	"共享剪贴板  

	set clipboard+=unnamed


	"从不备份  

	set nobackup

	set nowb

	set noswapfile

	"make 运行

	":set makeprg=g++\ -Wall\ \ %

	"自动保存

	"set autowrite

	"set cursorline              " 突出显示当前行

	set magic                   " 设置正则表达

	"set guioptions-=T           " 隐藏工具栏

	"set guioptions-=m           " 隐藏菜单栏

	"搜索忽略大小写

	set ignorecase

	"智能大小写

	set smartcase

	"搜索逐字符高亮

	set hlsearch

	set incsearch

	"行内替换

	set gdefault

	" 保存全局变量

	set viminfo+=!

	" 带有如下符号的单词不要被换行分割

	set iskeyword+=_,$,@,%,#,-

	" 字符间插入的像素行数目

	"set linespace=0

	" 增强模式中的命令行自动完成操作

	set wildmenu

	"忽略**文件

	set wildignore=*.o,*~,*.pyc

	" 使回格键（backspace）正常处理indent, eol, start等

	set backspace=2

	" 允许backspace和光标键跨越行边界

	set whichwrap+=<,>,h,l

	" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）

	set mouse=a

	set selection=exclusive

	set selectmode=mouse,key

	" 通过使用: commands命令，告诉我们文件的哪一行被改变过

	set report=0

	set fillchars=vert:\ ,stl:\ ,stlnc:\

	" 高亮显示匹配的括号

	set showmatch

	" 匹配括号高亮的时间（单位是十分之一秒）

	set matchtime=1

	" 光标移动到buffer的顶部和底部时保持3行距离

	set scrolloff=3

	" 自动换行

	set lbr
	set tw=78

	"智能缩进

	set ai
	set wrap
	set smartindent

	" 高亮显示普通txt文件（需要txt.vim脚本）

	"au BufRead,BufNewFile *  setfiletype txt



	" 设置注释
	vmap <F6> <Esc><Esc>:call EnhancedCommentify('yes','comment',line("'<"),line("'>"))<CR>
	" 取消注释
	vmap <C-F6> <Esc><Esc>:call EnhancedCommentify('yes','decomment',line("'<"),line("'>"))<CR>

	"整体编程缩进

	set sw=4
	set ts=4


	"text

	autocmd FileType text setlocal sw=8 ts=8 noai nocindent nosmartindent

	"RuntimePath
	"call pathogen#infect()


	" Return to last edit position when opening files (You want this!)
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif
	" Remember info about open buffers on close
	set viminfo^=%

if &filetype=='tex'
set textwidth=80
else
set textwidth=0
endif

set background=dark
autocmd BufNewFile,BufRead *.md set filetype=markdown
