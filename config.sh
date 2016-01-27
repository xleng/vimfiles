mkdir -p ~/.vim/bundle

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#ln -s `pwd`/vim   ~/.vim
if [ -e ~/.vimrc ]; then
   mv ~/.vimrc ~/.vimrc.bak
fi
ln -s `pwd`/vimrc ~/.vimrc

vim +PluginInstall +qall


