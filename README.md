README
======

This is simply a repository for my personal configurations. I use vim on a daily
basis and it's quite often that I have to move from one machine to another, so I
need a repository to synchronize my configurations.

Most of the stuffs are simply stolen from others, so there's no gurrantee that I
can maintain the configurations. If you want to use these configs, make sure you
got your git, vim and tmux installed, then clone the 'Vundle' repository:
`$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
Then open vim, typein ':PluginInstall' to install required plugins.

When using vim(nvim), it suppose to leverage vim-go and you need to run
`GoInstallBinaries` to install the binaries required.

To install it directly, try:
```
wget -qO - https://raw.githubusercontent.com/hanlins/vimrc/master/install.sh | bash -x
```

Have fun.
