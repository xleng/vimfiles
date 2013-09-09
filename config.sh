mkdir vim
git clone https://github.com/gmarik/vundle.git vim/bundle/vundle

ln -s vim   ~/.vim
ln -s vimrc ~/.vimrc

vim +BundleInstall +qall


