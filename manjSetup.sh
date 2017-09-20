#!/bin/bash

tmplog="~/tmp.log.txt"
echo making log file at $tmplog

echo "Started script at $(date)" > $tmplog

tmpDir=~/Documents/installScriptTmp
if [ ! -d $tmpDir ]
then
	echo "making script directory at $tmpDir"
	echo "making script directory at $tmpDir" >> $tmplog
	mkdir $tmpDir
else
	echo "$tmpDir already exists. Using old directory"
	echo "$tmpDir already exists. Using old directory" >> $tmplog
fi

logfile=$tmpDir/log.txt
if [ ! -f $logfile ]
then
	echo -n "creating log file at $logfile"
	mv $tmplog $logfile
	echo "moved $tmplog to file at $logfile" >> $logfile
fi

errorFile=$tmpDir/errors.txt
if [ ! -f $errorFile ]
then
	echo -n "creating error file at $errorFile"
	echo "created error file at $errorFile" >> $logfile
	touch $errorFile
fi

echo Setting up ssh keys...
ssh-keygen -t rsa

echo "updating repos..."
sudo pacman -Syu

## apt-get packages... Left out: "mongodb" "postgresql" "xbacklight" "i3" "gcc" "g++" 
packages=("vim" "git" "python2-pip" "python-pip" "curl" "ruby" "ruby-dev" "tree" "chromium" "firefox" "gnupg" "vlc" "compton" "adobe-flashplugin" "texlive-most" "texlive-lang" "ninvaders" "feh" "gimp" "xclip" "transmission" "r" "pandoc" "jdk8-openjdk" "jdk9-openjdk" "tmux" "tk" "pulseaudio-ctl" "pa-applet")

counter=0
for package in "${packages[@]}"
do
	counter=$(($counter + 1))
	echo -n "installing $counter package --  $package..." &&
		sudo pacman -S --noconfirm $package || echo "install error ==> $package\n" >> $errorFile
done

echo "================================================="
echo "================================================="
echo "================  Github/linking  ==============="
echo "================================================="
echo "================================================="

git config --global user.email "amniskin@gmail.com"&&
git config --global user.name "Aaron Niskin"

## cloning my dotfiles
git clone https://github.com/amniskin/.dotfiles.git ~/.dotfiles
## linking my dotfiles
# files=(".vimrc" ".bashrc" ".mrjob.conf" ".i3/config" ".i3/i3status.conf")

fileDir="~/.dotfiles/home"
oldDir="~/old"

if [ ! -d $oldDir ]; then
	mkdir $oldDir
fi

for file in $(ls $fileDir) ##  "${files[@]}"
do
	if [ -d $fileDir/$file ]; then
		if [ ! -d "~/$file" ]; then
			mkdir ~/$file
		fi
		for inner in $(ls $fileDir/$file); do
			if [ -f ~/$file/$inner ]; then
				mv ~/$file/$inner "$oldDir/$file..$inner" &&
				ln -s "$fileDir/$file/$inner" ~/$file/$inner
			fi
		done
	elif [ -f ~/$file ]; then
		mv ~/$file $oldDir/$file
	fi
	ln -s $fileDir/$file ~/$file ||
		echo "symlink error ==> $file\n" >> $errorFile
done


sudo bash -c "cd /usr/local/bin && curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && chmod 755 boot"

mkdir ~/.vim-tmp
echo "installing VimVundle... "
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "installing Vim Pluggins... "
vim +PluginInstall +qall

echo "================================================="
echo "================================================="
echo "=====================   pip   ==================="
echo "================================================="
echo "================================================="

##  pip packages
packages=("py3status" "numpy" "pandas" "matplotlib" "scikit-learn" "statsmodels" "pandas-datareader" "yahoo-finance" "wikipedia" "gensim" "beautifulsoup4" "scipy" "pymongo" "mrjob" "beautifulsoup4" "powerline-status" "cython" "jupyter")

sudo pip install --upgrade pip &&
	for package in "${packages[@]}"
	do
		sudo -H pip install $package ||
			echo "pip install error ==> $package\n" >> $errorFile
		sudo -H pip3 install $package ||
			echo "pip install error ==> $package\n" >> $errorFile
	done

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
		echo "gem install error ==> $package\n" >> $tmpDir/errors.txt
done

echo "Y'all have a good day now, y'hear?"
