#!/bin/bash

tmpDir=~/Documents/installScriptTmp
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

oldDir="~/old"
dirs=("$oldDir" "~/.r" "~/.config" "~/.config/r")
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

echo "updating repos..."
sudo pacman -Syu

## apt-get packages... Left out: "mongodb" "postgresql" "xbacklight" "i3" "gcc" "g++" 
packages=("vim" "git" "python2-pip" "python-pip" "curl" "ruby" "ruby-dev" "tree" "chromium" "firefox" "gnupg" "vlc" "compton" "adobe-flashplugin" "texlive-most" "texlive-lang" "ninvaders" "feh" "gimp" "xclip" "transmission" "r" "pandoc" "jdk8-openjdk" "jdk9-openjdk" "tmux" "tk" "pulseaudio-ctl" "pa-applet" "kcalc")

counter=0
for package in "${packages[@]}"
do
	counter=$(($counter + 1))
	echo -n "installing $counter package --  $package..." &&
		sudo pacman -S --noconfirm $package || echo "install error ==> $package" >> $errorFile
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

function rlink {
	####  recursively link files and create subdirectories as needed
	##
	## $1 = directory to link from
	## $2 = directory in which to link files.
	fromDir=$1
	toDir=$2
	for now in $(ls -A $fromDir); do
		from="$fromDir/$now"
		to=$toDir/$now
		if [ -f $from ]; then
			if [ -f $to ]; then
				tmp=$(echo $to | tr "/" "+")
				mv $to $old/$tmp && echo "Moved $to to $old/$tmp" >> $logFile
			fi
			ln -s $from $to
		elif [ -d $from ]; then
			if [ ! -d $to ]; then
				mkdir $to
			fi
			rlink $from $to
		fi
	done
}
fileDir="~/.dotfiles/home"
rlink $fileDir $HOME
##  for file in $(ls -A $fileDir) ##  "${files[@]}"
##  do
##  	if [ -d $fileDir/$file ]; then
##  		if [ ! -d "~/$file" ]; then
##  			mkdir ~/$file
##  		fi
##  		for inner in $(ls $fileDir/$file); do
##  			if [ -f ~/$file/$inner ]; then
##  				mv ~/$file/$inner "$oldDir/$file..$inner" &&
##  				ln -s "$fileDir/$file/$inner" ~/$file/$inner
##  			fi
##  		done
##  	elif [ -f ~/$file ]; then
##  		mv ~/$file $oldDir/$file
##  	fi
##  	ln -s $fileDir/$file ~/$file ||
##  		echo "symlink error ==> $file\n" >> $errorFile
##  done


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
			echo "pip install error ==> $package" >> $errorFile
		sudo -H pip2 install $package ||
			echo "pip2 install error ==> $package" >> $errorFile
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
	R -e "install.packages($package)" ||
		echo "R install error ==> $package" >> $errorFile
done

echo "Y'all have a good day now, y'hear?"
