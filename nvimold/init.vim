set nocompatible
"nnoremap p p`[v`]=
let &fcs='eob: '
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj
augroup TerminalStuff
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

noremap <C-S>       :update<CR>
vnoremap <C-S>      <C-C>:update<CR>
inoremap <C-S>      <C-O>:update<CR>

autocmd BufRead,BufNewFile *.x set filetype=objc
autocmd BufRead,BufNewFile *.xm set filetype=objc
tnoremap <Esc> <C-\><C-n>
set tabstop=4
set shiftwidth=4
set expandtab

"spellcheck
set spelllang=en,cjk
set spellsuggest=best,9
nnoremap <silent> <C-`> :set spell!<cr>
inoremap <silent> <C-`> <C-O>:set spell!<cr>


call plug#begin('~/.vim/plugged')
"Plug 'godlygeek/tabular'
"Plug '907th/vim-auto-save'
"Plug 'ycm-core/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'Shougo/ddc.vim'
"Plug 'https://github.com/Shougo/deoplete.nvim'
"Plug 'vim-denops/denops.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-ultisnips'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'lervag/vimtex'
"Plug 'ervandew/supertab'
" Plug 'nvim-lua/completion-nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'agude/vim-eldar'
Plug 'antoinemadec/FixCursorHold.nvim'
"Plug 'lambdalisue/fern.vim'
Plug 'NLKNguyen/papercolor-theme'
"Plug 'keith/swift.vim'
"Plug 'powerman/vim-plugin-AnsiEsc'


let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
"let g:deoplete#enable_at_startup = 1
" will fix someday but for now will press S-space
"inoremap <expr> <space><space> (pumvisible() ? "\<C-R>=UltiSnips#ExpandSnippet()\<CR>" : "\<space>\<space>")
let g:UltiSnipsExpandTrigger = '<s-space>'


call plug#end()

  
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'vimtex',
            \ 'priority': 1,
            \ 'subscope_enable': 1,
            \ 'complete_length': 1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \           'matchers': [
            \               {'name': 'abbrfuzzy', 'key': 'menu'},
            \               {'name': 'prefix', 'key': 'word'},
            \           ]},
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })

"let g:vimtex_compiler_latexmk_engines = {
"    \ '_'                : '-xelatex',
"    \ 'pdflatex'         : '-pdf',
"    \ 'dvipdfex'         : '-pdfdvi',
"    \ 'lualatex'         : '-lualatex',
"    \ 'xelatex'          : '-xelatex',
"    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
"    \ 'context (luatex)' : '-pdf -pdflatex=context',
"    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
"    \}
function! Func1()
    return (pumvisible() ? "\<C-p>" : "\<S-Tab>")
endfunction

function! Func2()
    return (pumvisible() ? "\<C-n>" : "\<Tab>")
endfunction


inoremap <expr> <Tab> Func2()
inoremap <expr> <S-Tab> Func1()
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
":
"call deoplete#custom#var('omni', 'input_patterns', {
"        \ 'tex': g:vimtex#re#deoplete
"        \})
""inoremap <silent><expr> <TAB>
""      \ pumvisible() ? "\<C-n>" :
""      \ <SID>check_back_space() ? "\<TAB>" :
""      \ coc#refresh()
""inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"
set number linebreak
"
"augroup autocom
"    autocmd!
"    "executes the command on quit
"    "autocmd VimLeave cat ~/MEGA/walThemes/MoonTheme 
"
"    "execute the command on write
"    autocmd BufWritePost,FileWritePost *.cpp !your_commad
"augroup END
"
"let g:syntastic_error_symbol = '✘'
"let g:syntastic_warning_symbol = "▲"
"augroup mySyntastic
"  au!
"  au FileType tex let b:syntastic_mode = "passive"
"augroup END
"
"
set background=dark
colorscheme eldar

let g:tex_flavor='latex' 
let g:vimtex_view_method = 'skim' 
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_activate = 1 
"
filetype plugin indent on
syntax enable
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
""let g:nerdtree_tabs_open_on_console_startup = 1
"
nmap <silent> <leader>n :tabnew<CR>
"
map <C-t><up> :tabr<cr>
"
map <C-t><down> :tabl<cr>
"
map <C-t><left> :tabp<cr>
"
map <C-t><right> :tabn<cr>

set ph=5

let mapleader=","



vnoremap  <leader>y  "*y
vnoremap  <leader>d  "*d

" Mappings

" <TAB>: completion.
"inoremap <silent><expr> <TAB>
"\ ddc#map#pum_visible() ? '<C-n>' :
"\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
"inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

" Use ddc.
"call ddc#enable()
