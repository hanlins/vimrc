#! /bin/bash

set -x

# install zsh
sudo apt-get install git -y
sudo apt-get install zsh -y
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install

# install nvim
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim -y
sudo apt-get install gcc -y
sudo apt-get install make -y
sudo apt-get install git -y
sudo apt-get install bison -y
sudo apt-get install silversearcher-ag -y

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install tmux
sudo apt-get install tmux -y

# load configurations
wget -O ~/.gitconfig https://raw.githubusercontent.com/hanlins/vimrc/master/.gitconfig
wget -O ~/.tmux.conf https://raw.githubusercontent.com/hanlins/vimrc/master/.tmux.conf
mkdir -p .config/nvim/
wget -O ~/.config/nvim/init.vim https://raw.githubusercontent.com/hanlins/vimrc/master/.vimrc

# download gvm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
echo "source /root/.gvm/scripts/gvm"
source /root/.gvm/scripts/gvm
gvm install go1.15.7 -B
gvm use go.1.15.7

# switch to zsh
chsh -s $(which zsh)

