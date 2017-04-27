tmpDir=~/Documents/installScriptTmp
if [ ! -d $tmpDir ]
then
	echo "making script directory at $tmpDir"
	mkdir $tmpDir
else
	echo "$tmpDir already exists. Using old directory"
fi
echo "updating repos..."
sudo -H apt-get update
echo "copying /etc/apt/sources.list to $tmpDir/sources.list"
cp /etc/apt/sources.list $tmpDir/
## echo "adding canonical parter repos..."
## cat /etc/apt/sources.list | sed -r 's/\#\ deb\ (.*)partner/deb\ \1partner/' > /etc/apt/sources.list

echo "" > $tmpDir/errors.txt

## apt-get packages
packages=("i3" "xbacklight" "python-pip" "curl" "mongodb" "postgresql" "ruby"
"ruby-dev" "jekyll" "tree" "chromium-browser" "firefox" "gnupg" "vlc" "compton"
"adobe-flashplugin" "texlive-full" "ninvaders" "gcc" "g++" "feh" "gimp" "xclip"
"transmission" "r-base" "pandoc" "openjdk-8-jdk" "openjdk-8-jre" "default-jre"
"default-jdk")

for package in "${pacakges[@]}"
do
	echo "installing $package..." &&
		sudo apt-get install $package || echo "apt-get install error ==> $package\n" >> $tmpDir/errors.txt
done

echo "================================================="
echo "================================================="
echo "================  Github/linking  ==============="
echo "================================================="
echo "================================================="

git config --global user.email "amniskin@gmail.com"&&
git config --global user.name "Aaron Niskin"

## cloning my dotfiles
git clone https://github.com/amniskin/.dotfiles.git ~/.dotfiles &&
do
	## linking my dotfiles
	files=(".vimrc" ".bashrc" ".bash_aliases" ".mrjob.conf" ".i3/config"
	".i3/i3status.conf")

	for file in "${files[@]}"
	do
		ln -s ~/.dotfiles/home/$file ~/$file ||
			echo "symlink error ==> $file\n" >> $tmpDir/errors.txt
	done

	sudo bash -c "cd /usr/local/bin && curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && chmod 755 boot"

	mkdir ~/.vim-tmp
	echo "installing VimVundle... "
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	echo "installing Vim Pluggins... "
	vim +PluginInstall +qall
done

echo "================================================="
echo "================================================="
echo "=====================   pip   ==================="
echo "================================================="
echo "================================================="

## pip packages
packages=("py3status")

sudo pip install --upgrade pip &&
	for package in "${packages[@]}"
	do
		sudo -H pip install $package ||
			echo "pip install error ==> $package\n" >> $tmpDir/errors.txt
	done

echo "================================================="
echo "================================================="
echo "==================   Anaconda   ================="
echo "================================================="
echo "================================================="

echo "installing anaconda..."
CONTREPO=https://repo.continuum.io/archive/
# Stepwise filtering of the html at $CONTREPO
# Get the topmost line that matches our requirements, extract the file name.
ANACONDAURL=$(wget -q -O - $CONTREPO index.html | grep "Anaconda3-" | grep "Linux" | grep "86_64" | head -n 1 | cut -d \" -f 2)
wget -O $tmpDir/anaconda.sh $CONTREPO$ANACONDAURL
bash $tmpDir/anaconda.sh

echo "================================================="
echo "================================================="
echo "===============  Conda Packages  ================"
echo "================================================="
echo "================================================="

## conda packages
packages=("numpy" "pandas" "matplotlib" "scikit-learn" "statsmodels"
"pymongo" "pandas-datareader" "yahoo-finance" "wikipedia" "gensim"
"mrjob" "beautifulsoup4")

for package in "${packages[@]}"
do
	conda install $package ||
		conda install $package -c conda-forge ||
		echo "conda install error ==> $package\n" >> $tmpDir/errors.txt
done

echo "================================================="
echo "================================================="
echo "===================  Ruby  ======================"
echo "================================================="
echo "================================================="

## ruby gems
packages=("bundler")
for package in "${packages[@]}"
do
	gem install $package ||
		echo "gem install error ==> $package\n" >> $tmpDir/errors.txt
done

echo "Y'all have a good day now, y'hear?"
