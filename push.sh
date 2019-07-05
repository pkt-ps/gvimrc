SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd ${SCRIPT_DIR}

# vimrc copy
cp ~/.vimrc .vimrc
cp ~/.vsvimrc .vsvimrc
cp ~/_gvimrc _gvimrc

#toml copy
cp ~/.vim/toml/plugin.toml plugin.toml
cp ~/.vim/toml/plugin_lazy.toml plugin_lazy.toml

git add -A
git commit
git push origin master
