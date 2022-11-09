#! /bin/bash

set -x

# install zsh
sudo apt-get install git -y
sudo apt-get install zsh -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install

# install docker registry
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

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
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# add docker to docker user group
sudo groupadd docker
sudo usermod -aG docker $USER

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
gvm use go1.15.7

echo "source /root/.gvm/scripts/gvm" >> ~/.zshrc
echo "gvm use go1.15.7" >> ~/.zshrc
echo 'alias vim="nvim"' >> ~/.zshrc

# switch to zsh
chsh -s $(which zsh)

