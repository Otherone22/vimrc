source $VIMRUNTIME/vimrc_example.vim
set directory=~/.vim/backup/
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/
set nobackup
set nowritebackup

autocmd GUIEnter * simalt ~x
set number relativenumber
set spell spelllang=en_us
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'cosminadrianpopescu/vim-tail'
Plug 'junegunn/fzf'
Plug 'wincent/ferret'
Plug 'BurntSushi/ripgrep'
call plug#end()
syntax on
colorscheme onedark
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

inoremap jk <ESC>
noremap <Leader>x :noh<CR>
let mapleader = " "
noremap , :edit $MYVIMRC<CR>
noremap <Leader>r :source $MYVIMRC<CR>
noremap <Leader>p "+p
noremap <Leader>c "+y
noremap <Leader>a ggVG
noremap <C-n> :tabnew
noremap <Leader>t :TailStart
noremap <Leader>u :TailStop
noremap <C-r> :redo<CR>
