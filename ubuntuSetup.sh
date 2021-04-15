#!/bin/bash

tmpDir=~/Documents/installScriptTmp
if [ ! -d $tmpDir ]
then
	echo "making script directory at $tmpDir"
	mkdir $tmpDir
else
	echo "$tmpDir already exists. Using old directory"
fi

errorFile=$tmpDir/errors.txt
logFile="$tmpDir/log.txt"

# echo Setting up ssh keys...
# ssh-keygen -t rsa


echo "updating repos..."
sudo apt-get update

sudo apt-get install vim git i3 xbacklight python3-dev python3-pip \
 python3-virtualenv curl ruby ruby-dev jekyll tree chromium-browser firefox \
 gnupg vlc compton ninvaders gcc g++ feh gimp xclip \
 transmission r-base pandoc default-jre default-jdk tmux suckless-tools

git config --global user.email "amniskin@gmail.com"&&
git config --global user.name "Aaron Niskin"

## cloning my dotfiles
# git clone https://github.com/amniskin/.dotfiles.git ~/.dotfiles
bash $HOME/.dotfiles/link_files.bash >> $logFile

echo "===================   Boot   ===================="
sudo bash -c "cd /usr/local/bin && curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && chmod 755 boot"
mkdir $HOME/.boot $HOME/.m2

echo "================================================="
echo "================================================="
echo "===================  Ruby  ======================"
echo "================================================="
echo "================================================="

packages=("bundler" "jekyll")
for package in "${packages[@]}"
do
	gem install $package ||
		echo "gem install error ==> $package\n" >> $logFile
done

echo "installing VimVundle... "
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "installing Vim Pluggins... "
vim +PluginInstall +qall

mkdir -p $HOME/.misc_things/ &&
	cd $HOME/.misc_things &&
	git clone git@github.com:Boruch-Baum/morc_menu.git &&
	cd morc_menu &&
	sudo make install

curl -fsSL https://raw.githubusercontent.com/adzerk-oss/zerkenv/master/zerkenv > ~/.local/bin/zerkenv
chmod 755 ~/.local/bin/zerkenv

echo "Y'all have a good day now, y'hear?"
