mkdir -p ~/.vim/pack/my/start
mkdir -p ~/.vim/pack/colors

# --------------------------------------------
# Color Scheme
# --------------------------------------------
cd ~/.vim/pack/
git clone https://github.com/tomasr/molokai.git
mv .\molokai\colors\molokai.vim .\colors

# --------------------------------------------
# Plugin
# --------------------------------------------
cd ~/.vim/pack/my/start
git clone https://github.com/scrooloose/nerdtree.git
# git clone https://github.com/jistr/vim-nerdtree-tabs.git
git clone https://github.com/nathanaelkane/vim-indent-guides.git
git clone https://github.com/thinca/vim-singleton.git
git clone https://github.com/itchyny/vim-highlighturl.git
git clone https://github.com/mopp/next-alter.vim

# --------------------------------------------
# Plugin Unite
# --------------------------------------------
git clone https://github.com/Shougo/unite.vim.git
git clone https://github.com/Shougo/neomru.vim.git
git clone https://github.com/Shougo/neoyank.vim.git
