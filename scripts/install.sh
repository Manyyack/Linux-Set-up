#!/bin/bash

if [ "$1" == "help" ] || [ $# -ne 1 ];
then
    echo "usage ./install.sh <Option>"
    echo "Options           Description"
    echo "help  :       to see this print"
    echo "vim   :       to install the vim settings only"
    echo "update:       to update the installed plugin" 
    echo "ycm   :       to install clang completer for ycm"
    echo "git   :       to install the git settings only"
    echo "bash  :       to install the bash settings only"
    echo "conky :       to install the conky settings only"
    echo "packs :       to install my personal packages"
    echo "all   :       for the complete setup"
    echo "clean :       to remove the complete setup"
    exit 1
fi

uservar=$(whoami)

echo "*************Going to install the Shreel's set up for $1***************** "
echo "Installation being carried out for user $uservar only"

if [ "$1" == "clean" ];
then
    sudo rm -rvf ~/.vim/bundle/Vundle.vim
    sudo apt-get -y remove fonts-powerline exuberant-ctags cscope build-essential cmake python3-dev ack-grep conky-all
    sudo rm ~/.vimrc
    sudo rm ~/.ackrc
    sudo rm -rvf ~/.vim 
    sudo rm ~/.gitconfig
    sudo rm ~/.gitconfig
    rm ~/.conkyrc
    rm ~/.conkylogs
fi

if [ "$1" == "vim" ] || [ "$1" == "all" ];
then
    # Vim set up
    echo "Installing Vundle "
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    #TODO : Need to seperate depencies according to the distro.
    echo "Installing all the dependencies "
    sudo apt-get -y install fonts-powerline exuberant-ctags cscope build-essential cmake python3-dev ack-grep

    echo "Replacing the .vimrc files "
    sudo rm ~/.vimrc
    ln -s ~/Linux-Set-up/rc_files/vimrc ~/.vimrc

    echo "Installing all the plugins "
    vim --cmd silent! +PluginInstall +qal

    mkdir ~/.vim/undo
    sudo chown $uservar ~/.vim/undo

    echo "Putting in the .ackrc files "
    sudo rm ~/.ackrc
    ln -s ~/Linux-Set-up/rc_files/ackrc ~/.ackrc

    echo "Copying Ultisnips"
    sudo rm ~/.vim/my-snippets/c.snippets
    mkdir ~/.vim/my-snippets
    ln -s ~/Linux-Set-up/ultisnips/c.snippets ~/.vim/my-snippets/c.snippets

    echo "Installing the C syntax file "
    sudo rm ~/.vim/after/syntax/c.vim
    mkdir -p ~/.vim/after/syntax/
    sudo chown $uservar ~/.vim/after
    sudo chown $uservar ~/.vim/after/syntax
    ln -s ~/Linux-Set-up/syntax/c.vim ~/.vim/after/syntax/c.vim

    echo "Setting up the colorschemes "
    sudo rm ~/.vim/bundle/vim-colorschemes/colors/heroku-terminal.vim
    sudo ln -s ~/Linux-Set-up/colors/heroku-terminal.vim ~/.vim/bundle/vim-colorschemes/colors/heroku-terminal.vim
    sudo rm ~/.vim/bundle/vim-airline-themes/autoload/airline/themes/badwolf.vim
    sudo ln -s ~/Linux-Set-up/colors/badwolf.vim ~/.vim/bundle/vim-airline-themes/autoload/airline/themes/badwolf.vim

    echo "Resetting .viminfo to remove ownership of root"
    sudo chown $uservar ~/.viminfo
fi

if [ "$1" == "update" ] || [ "$1" == "all" ];
then
    echo "Updating the installed plugin"
    vim +PluginUpdate +qal
fi

if [ "$1" == "ycm" ] || [ "$1" == "all" ];
then
    echo "Installing YCM engine and updating it. "
    cd ~/.vim/bundle/YouCompleteMe
    sudo ./install.py --clang-completer
fi

if [ "$1" == "git" ] || [ "$1" == "all" ];
then
    echo "Adding the git config"
    sudo rm ~/.gitconfig
    ln -s ~/Linux-Set-up/rc_files/gitconfig ~/.gitconfig
fi

if [ "$1" == "conky" ] || [ "$1" == "all" ];
then
    sudo apt -y install conky-all
    echo "Putting in the .conkyrc files"
    rm ~/.conkyrc
    rm ~/.conkylogs
    ln -s ~/Linux-Set-up/rc_files/conkyrc ~/.conkyrc
    ln -s ~/Linux-Set-up/rc_files/conkylogs ~/.conkylogs

    # newvar=/home/uservar/Linux-Set-up/wallpaper/linux_sudo.png
    # echo "Setting the wallpaper"
    # echo $newvar
    # sudo -u uservar gsettings set org.gnome.desktop.background picture-uri file://$newvar

    exit 1
fi

if [ "$1" == "packs" ] || [ "$1" == "all" ];
then
    sudo apt-get -y install numlockx 

echo "*************Shreel's set up is complete for $1***************** "