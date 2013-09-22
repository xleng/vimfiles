mkdir vim
git clone https://github.com/gmarik/vundle.git vim/bundle/vundle

ln -s `pwd`/vim   ~/.vim
ln -s `pwd`/vimrc ~/.vimrc

vim +BundleInstall +qall


