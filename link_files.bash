#!/usr/bin/env bash
## linking my dotfiles
# olddir="$HOME/old"
basedir=$1
olddir=$2

for from in $(find $basedir); do
	to=$(echo $from | sed 's/\/.dotfiles\/home//')
	if [ -f $from ]; then
		if [ -f $to ]; then
			tmp=$toDir/$(echo $to | tr "/" "+")
			mv $to $olddir/$tmp && echo "moved $to to $olddir/$tmp"
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
