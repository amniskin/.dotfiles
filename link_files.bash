#!/usr/bin/env bash
## linking my dotfiles
oldDir="$HOME/old"

for from in $(find $HOME/.dotfiles/home); do
	to=$(echo $from | sed 's/\/.dotfiles\/home//')
	if [ -f $from ]; then
		if [ -f $to ]; then
			tmp=$toDir/$(echo $to | tr "/" "+")
			mv $to $oldDir/$tmp && echo "moved $to to $oldDir/$tmp"
		fi
		echo "Linking $from $to"
		ln -s $from $to || echo "error creating symbolic link from $from to $to"
  elif [ -d $from ]; then
    if [ -d $to ]; then
      echo "Skipping $from to $to because $to already exists"
    else
      mkdir -p $to
    fi
	else
		echo "skipping $from because it's not a file nor a directory"
	fi
done
