tmpDir=~/Documents/installScriptTmp
echo "making script directory at $tmpDir"
mkdir $tmpDir
echo "copying /etc/apt/sources.list to $tmpDir/sources.list"
cp /etc/apt/sources.list $tmpDir/
echo "adding canonical parter repos..."
cat /etc/apt/sources.list | sed -r 's/\#\ deb\ (.*)partner/deb\ \1partner/' > /etc/apt/sources.list
echo "updating repos..."
sudo apt-get update
echo "installing anaconda..."
CONTREPO=https://repo.continuum.io/archive/
# Stepwise filtering of the html at $CONTREPO
# Get the topmost line that matches our requirements, extract the file name.
ANACONDAURL=$(wget -q -O - $CONTREPO index.html | grep "Anaconda3-" | grep "Linux" | grep "86_64" | head -n 1 | cut -d \" -f 2)
wget -O $tmpDir/anaconda.sh $CONTREPO$ANACONDAURL
bash $tmpDir/anaconda.sh
echo "installing mongodb and pymongo..."
sudo apt-get install mongodb
conda install pymongo
echo "installing postgresql..."
sudo apt-get install postgresql
echo "installing curl..."
sudo apt-get install curl
echo "installing docker..."
sudo apt-get install docker
echo "installing git..."
sudo apt-get install git
git config --global user.email "amniskin@gmail.com"
git config --global user.name "Aaron Niskin"
echo "installing Vim..."
mkdir ~/.vim-tmp
sudo apt-get install vim
echo "installing VimVundle... "
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "installing Vim Pluggins... "
vim +PluginInstall +qall
echo "installing tree... "
sudo apt-get install tree
echo "installing chromium... "
sudo apt-get install chromium
echo "installing firefox... "
sudo apt-get install firefox
## echo "installing flash player..."
## sudo apt-get install adobe-flashplugin

# echo "installing pip... "
# sudo apt-get install python-pip
# sudo apt-get install python3-pip
echo "installing gnupg... "
sudo apt-get install gnupg
echo "installing VLC... "
sudo apt-get install vlc
echo "installing texlive... "
sudo apt-get install texlive-full
echo "installing ninvaders... "
sudo apt-get install ninvaders
echo "installing gcc... "
sudo apt-get install gcc
echo "installing g++... "
sudo apt-get install g++
echo "installing compton... "
sudo apt-get install compton
echo "installing feh... "
sudo apt-get install feh


echo "Y'all have a good day now, y'hear?"
