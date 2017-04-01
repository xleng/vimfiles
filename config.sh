
OS=`uname`

if [[ $OS == MINGW* ]]; then
   VIMRC=_vimrc
   VIMDIR=vimfiles
   echo "Windows use $VIMDIR and $VIMRC"
else
   VIMRC=.vimrc
   VIMDIR=.vim
   echo "NOT Windows OS"
fi

mkdir -p ~/$VIMDIR/bundle

git clone https://github.com/VundleVim/Vundle.vim.git ~/$VIMDIR/bundle/Vundle.vim

if [ -e ~/$VIMRC ]; then
   mv ~/$VIMRC ~/$VIMRC.bak
fi
ln -s `pwd`/vimrc ~/$VIMRC

vim +PluginInstall +qall

