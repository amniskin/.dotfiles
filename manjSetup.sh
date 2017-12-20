#!/bin/bash

tmpDir=$HOME/Documents/installScriptTmp
if [ ! -d $tmpDir ]; then
	mkdir $tmpDir
fi

logFile="$tmpDir/log.txt"
if [ ! -f $logFile ]; then
	echo "Started script at $(date)" > $logFile
else
	for i in {1..4}; do
		for j in {1..50}; do
			echo -n "="
		done
	done
	echo "Restarted script at $(date)" > $logFile
fi

echo "Making directories..."

oldDir="$HOME/old"
dirs=("$oldDir" "$HOME/.r" "$HOME/.config" "$HOME/.config/r")
for dir in "${dirs[@]}"; do
	if [ ! -d $dir ]; then
		mkdir $dir && echo "Made directory at $dir" >> $logFile
	else
		echo "$dir already exists. Using old directory" >> $logFile
	fi
done


errorFile=$tmpDir/errors.txt
files=("$errorFile")
for file in "${files[@]}"; do
	if [ ! -f $file ]; then
		touch $file && echo "Made $file" >> $logFile
	else
		echo "$file already exists... Using old." >> $logFile
	fi
done

echo Setting up ssh keys...
ssh-keygen -t rsa


echo "================================================="
echo "================================================="
echo "==================   PacMan   ==================="
echo "================================================="
echo "================================================="

echo "updating repos..."
sudo pacman -Syu

## apt-get packages... Left out: "mongodb" "postgresql" "xbacklight" "i3" "gcc" "g++" 
packages=("xclip" "bash-completion" "vim" "git" "python2-pip" "python-pip" "curl" "ruby" "ruby-dev" "tree" "chromium" "firefox" "gnupg" "vlc" "compton" "adobe-flashplugin" "ninvaders" "feh" "gimp" "transmission" "r" "pandoc" "jdk8-openjdk" "jdk9-openjdk" "tmux" "tk" "pulseaudio-ctl" "pa-applet" "kcalc" "qt4" "texlive-most" "dosfstools" "postgresql" "mongodb" "conky-lua-nv" "udisks2")

counter=0
for package in "${packages[@]}"
do
	counter=$(($counter + 1))
	echo -n "installing $counter package --  $package..." &&
		sudo -H pacman -S --noconfirm $package || echo "install error ==> $package" >> $errorFile
done

echo "================================================="
echo "================================================="
echo "================  Github/linking  ==============="
echo "================================================="
echo "================================================="

git config --global user.email "amniskin@gmail.com"&&
	git config --global user.name "Aaron Niskin"

## cloning my dotfiles
git clone git@github.com:amniskin/.dotfiles.git $HOME/.dotfiles
## linking my dotfiles

for from in $(find $HOME/.dotfiles/home); do
	to=$(echo $from | sed 's/\/.dotfiles\/home//')
	if [ -f $from ]; then
		if [ -f $to ]; then
			tmp=$toDir/$(echo $to | tr "/" "+")
			mv $to $oldDir/$tmp && echo "moved $to to $oldDir/$tmp" >> $logFile
		fi
		echo "Linking $from $to"
		ln -s $from $to || echo "failed symbolic link from $from to $to"
	else
		echo "skipping $from"
	fi
done

mkdir $HOME/.vim-tmp
echo "installing VimVundle... "
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
echo "installing Vim Pluggins... "
vim +PluginInstall +qall

echo "===================   Boot   ===================="
sudo bash -c "cd /usr/local/bin && curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && chmod 755 boot"

echo "================================================="
echo "================================================="
echo "====================   pip   ===================="
echo "================================================="
echo "================================================="

##  pip packages
packages=("py3status" "numpy" "pandas" "matplotlib" "scikit-learn" "statsmodels" "pandas-datareader" "yahoo-finance" "wikipedia" "gensim" "beautifulsoup4" "scipy" "pymongo" "mrjob" "beautifulsoup4" "powerline-status" "cython")

sudo pip install --upgrade pip &&
	sudo -H pip install jupyter &&
	for package in "${packages[@]}"
	do
		sudo -H pip install $package ||
			echo "pip install error ==> $package" >> $errorFile
		sudo -H pip2 install $package ||
			echo "pip install error ==> $package" >> $errorFile
	done

sudo -H pip install jupyter &&
	sudo -H pip2 install ipykernel &&
	python2 -m ipykernel install --user
sudo -H pip install jupyter_contrib_nbextensions &&
	jupyter contrib nbextension install --user


echo "================================================="
echo "================================================="
echo "===================  Ruby  ======================"
echo "================================================="
echo "================================================="

## ruby gems
packages=("bundler" "jekyll")
for package in "${packages[@]}"
do
	gem install $package ||
		echo "gem install error ==> $package" >> $errorFile
done


echo "================================================="
echo "================================================="
echo "=====================  R  ======================="
echo "================================================="
echo "================================================="

## ruby gems
packages=("dplyr" "tidyverse" "rmarkdown")
for package in "${packages[@]}"
do
	R -e "install.packages(\"$package\", lib=\"$HOME/.r\")" ||
		echo "R install error ==> $package" >> $errorFile
done

echo "Y'all have a good day now, y'hear?"
