SCRIPT_DIR=`dirname $0`
cd ${SCRIPT_DIR}

# vimrc copy
cp .vimrc ~/.vimrc
cp .vsvimrc ~/.vsvimrc
cp _gvimrc ~/_gvimrc

# plugin(dein)
mkdir -p ~/.vim
cd ~/.vim

if [ ! -e ~/.vim/bundles ]; then
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.vim/bundles
fi
