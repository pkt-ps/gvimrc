SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd ${SCRIPT_DIR}

#make directory
mkdir -p ~/.vim
mkdir -p ~/.vim/toml
mkdir -p ~/.vim/pack/my/start
mkdir -p ~/.vim/pack/my/opt

# vimrc copy
cp .vimrc ~/.vimrc
cp .vsvimrc ~/.vsvimrc
cp _gvimrc ~/_gvimrc

#toml copy
cp plugin.toml ~/.vim/toml/plugin.toml
cp plugin_lazy.toml ~/.vim/toml/plugin_lazy.toml

# plugin(dein)
pushd ~/.vim
if [ ! -e ~/.vim/bundles ]; then
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.vim/bundles
fi

# plugin(other)
popd
cp -rp ./plugin/* ~/.vim/pack/my/start
