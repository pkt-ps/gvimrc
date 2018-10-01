SCRIPT_DIR=`dirname $0`
cd ${SCRIPT_DIR}

mkdir ~/.vim
cd ./.vim

mkdir -p ./pack/my/start
mkdir -p ./pack/my/opt
mkdir -p ./colors

# Color Scheme
git clone https://github.com/tomasr/molokai.git
mv .\molokai\colors\molokai.vim .\colors

# Plugin
cd ./pack/my/start
git clone https://github.com/scrooloose/nerdtree.git

