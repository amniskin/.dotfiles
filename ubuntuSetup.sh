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

if [ ! -f $logFile ]; then
	echo "Started script at $(date)" > $logFile
	echo "----------------------------------------"
else
	for i in {1..4}; do
		for j in {1..50}; do
			echo -n "="
		done
	done
	echo "Restarted script at $(date)" > $logFile
	echo "----------------------------------------"
fi

echo Setting up ssh keys...
ssh-keygen -t rsa


echo "updating repos..."
sudo -H apt-get update
echo "copying /etc/apt/sources.list to $tmpDir/sources.list"
cp /etc/apt/sources.list $tmpDir/
## echo "adding canonical parter repos..."
## cat /etc/apt/sources.list | sed -r 's/\#\ deb\ (.*)partner/deb\ \1partner/' > /etc/apt/sources.list

## apt-get packages... Left out: "mongodb" "postgresql" texlive-full
packages=(vim git i3 xbacklight python3-dev python3-pip python3-virtualenv curl ruby ruby-dev jekyll tree chromium-browser firefox gnupg vlc compton adobe-flashplugin ninvaders gcc g++ feh gimp xclip transmission r-base pandoc default-jre default-jdk tmux suckless-tools)

for package in "${packages[@]}"
do
	echo "installing $package..." &&
		sudo apt-get install -yq $package || echo "apt-get install error ==> $package\n" >> $logFile
done

echo "================================================="
echo "================================================="
echo "================  Github/linking  ==============="
echo "================================================="
echo "================================================="

git config --global user.email "amniskin@gmail.com"&&
git config --global user.name "Aaron Niskin"

## cloning my dotfiles
# git clone https://github.com/amniskin/.dotfiles.git ~/.dotfiles
bash $HOME/.dotfiles/link_files.bash >> $logFile

echo "===================   Boot   ===================="
sudo bash -c "cd /usr/local/bin && curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && chmod 755 boot"

echo "================================================="
echo "================================================="
echo "=====================   pip   ==================="
echo "================================================="
echo "================================================="

##  pip packages
sudo python3 -m pip install --force-reinstall pip &&
  pip install -r $HOME/.dotfiles/pip_packages.txt

jupyter contrib nbextension install --user

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

echo "================================================="
echo "================================================="
echo "=====================  R  ======================="
echo "================================================="
echo "================================================="

packages=("dplyr" "tidyverse" "rmarkdown")
for package in "${packages[@]}"
do
	R -e "install.packages(\"$package\", lib=\"$HOME/.r\")" ||
		echo "R install error ==> $package" >> $logFile
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

echo "Y'all have a good day now, y'hear?"
