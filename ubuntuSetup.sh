#!/bin/bash

script_home=$(dirname $(realpath $0))
tmpdir=$HOME/Documents/installScriptTmp
usage() {
    local name=$(basename $0)
    cat <<EOT
    Set up an ubuntu machine the way I like it...

    usage: $name [-d TMP_HOME] [-n]

    options:
    -d TMP_HOME    Specify where the temporary home directory is. It's useful
                   to not have this be a temporary directory in case something
                   goes wrong. Default: $tmpdir
    -n             Don't install things like i3wm, firefox, etc.
EOT
}

while getopts "hd:n" opt; do
    case ${opt} in
        h ) usage && exit 0;;
        d ) tmpdir="$OPTARG" ;;
        n ) noinstall=1 ;;
        \? ) usage && exit 1 ;;
    esac
done
shift $((OPTIND -1))

if [ ! -d $tmpdir ]
then
    echo "making script directory at $tmpdir"
    mkdir -p $tmpdir
else
    echo "$tmpdir already exists. Using old directory"
fi

errorFile=$tmpdir/errors.txt
logFile="$tmpdir/log.txt"

echo "updating repos..."
sudo apt-get update >> $logFile

sudo apt-get install -y software-properties-common >> $logFile
sudo add-apt-repository -y ppa:deadsnakes/ppa >> $logFile
sudo apt-get update >> $logFile
sudo apt-get install -y vim git python3-dev python3-pip python3-venv curl jekyll tree gnupg ninvaders gcc g++ pandoc default-jre default-jdk tmux suckless-tools ctags >> $logFile

pip install pipx >> $logFile
pipx install hatch >> $logFile

git config --global user.email "amniskin@gmail.com" &&
    git config --global user.name "Aaron Niskin"

## cloning my dotfiles
# git clone https://github.com/amniskin/.dotfiles.git ~/.dotfiles
bash $script_home/link_files.bash $script_home/home $tmpdir >> $logFile

if [ -z ${noinstall+x} ]; then
    sudo apt-get install -y i3 xbacklight jekyll chromium-browser firefox compton feh transmission ruby ruby-dev gimp xclip
    cat <<EOT | bash
    cd $tmpdir &&
        git clone git@github.com:Boruch-Baum/morc_menu.git &&
        cd morc_menu &&
        sudo make install
EOT
    packages=("bundler" "jekyll")
    for package in "${packages[@]}"
    do
        gem install $package ||
            echo "gem install error ==> $package\n" >> $logFile
    done
else
    echo "skipping interactive stuff..."
fi

mkdir $HOME/.vim-tmp
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd $tmpdir &&
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&
    unzip awscliv2.zip &&
    sudo ./aws/install &&
    rm -rf ./aws awscliv2.zip
cd $HOME

sudo bash -c "cd /usr/local/bin && curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && chmod 755 boot"
mkdir $HOME/.boot $HOME/.m2

if [ ! -d $HOME/.local/bin ]; then
    mkdir -p $HOME/.local/bin
fi
curl -fsSL https://raw.githubusercontent.com/adzerk-oss/zerkenv/master/zerkenv > $HOME/.local/bin/zerkenv
chmod 755 $HOME/.local/bin/zerkenv

sudo bash -c "cd /usr/local && wget -O - https://github.com/micha/json-table/raw/master/jt.tar.gz | tar xzvf -"

echo "Y'all have a good day now, y'hear?"
