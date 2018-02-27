set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'ervandew/eclim'
Plugin 'ervandew/matchem'
Plugin 'ervandew/maximize'
Plugin 'ervandew/lookup'
Plugin 'ervandew/relative'
Plugin 'ervandew/sgmlendtag'
Plugin 'ervandew/vunit'
Plugin 'majutsushi/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dispatch'
Plugin 'duff/vim-bufonly'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/powerline-fonts'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-repeat'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-scripts/gtags.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'szw/vim-ctrlspace'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim'
Plugin 'jacoborus/tender.vim'
Bundle 'sonph/onehalf', {'rtp': 'vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
