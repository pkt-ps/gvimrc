SCRIPT_DIR=`dirname $0`
cd ${SCRIPT_DIR}

#make directory
mkdir -p ~/.vim
mkdir -p ~/.vim/toml

# vimrc copy
cp .vimrc ~/.vimrc
cp .vsvimrc ~/.vsvimrc
cp _gvimrc ~/_gvimrc

#toml copy
cp plugin.toml ~/.vim/toml/plugin.toml
cp plugin_lazy.toml ~/.vim/toml/plugin_lazy.toml

# plugin(dein)
cd ~/.vim

if [ ! -e ~/.vim/bundles ]; then
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.vim/bundles
fi
