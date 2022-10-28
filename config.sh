
OS=`uname`

if [[ $OS == MINGW* ]]; then
   VIMRC=vimrc
   VIMDIR=vimfiles
   echo "Windows use $VIMDIR and $VIMRC"
else
   VIMRC=.vimrc
   VIMDIR=.vim
   echo "NOT Windows OS"
   sudo apt-get install vim-nox git build-essential cmake python3-dev
fi

mkdir -p ~/$VIMDIR/bundle

git clone https://github.com/VundleVim/Vundle.vim.git ~/$VIMDIR/bundle/Vundle.vim


if ! [[ $OS == MINGW* ]]; then
   echo "link"
   if [ -e ~/$VIMRC ]; then
      mv ~/$VIMRC ~/$VIMRC.bak
   fi
   ln -s `pwd`/vimrc ~/$VIMRC
fi

vim +PluginInstall +qall

# install YCM
cd ~/$VIMDIR/bundle/YouCompleteMe
./install.py --clangd-completer --verbose
