
OS=`uname`

if [[ $OS == MINGW* ]]; then
   VIMRC=vimrc
   VIMDIR=vimfiles
   echo "Windows use $VIMDIR and $VIMRC"
else
   VIMRC=.vimrc
   VIMDIR=.vim
   echo "NOT Windows OS"
   sudo apt-get install vim git ctags build-essential cmake python3-dev


fi

#mkdir -p ~/$VIMDIR/bundle
#git clone https://github.com/VundleVim/Vundle.vim.git ~/$VIMDIR/bundle/Vundle.vim

curl -fLo ~/$VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if ! [[ $OS == MINGW* ]]; then
   echo "link"
   if [ -e ~/$VIMRC ]; then
      mv ~/$VIMRC ~/$VIMRC.bak
   fi
   ln -s `pwd`/vimrc ~/$VIMRC
fi

vim +PlugInstall

# install YCM
cd ~/$VIMDIR/plugged/YouCompleteMe
#./install.py --clang-completer
./install.py
