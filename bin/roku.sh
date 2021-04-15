#!/usr/bin/env bash
# -*- coding: utf-8 -*-

##  KEYPRESS='select'
##  echo -e "\n\nStarting Text Field\n===================\n"
##  while read -p key # 1 char (not delimiter), silent
##  do
##    echo "The line was... $key"
##  done
##  echo $KEYPRESS
##  exit

URL='http://192.168.1.2'
PORT='8060'

USAGE="$0 [url]"

if [ $# -gt 1 ]; then
  echo 'too many arguments!'
  echo "usage: $USAGE"
  exit 1
elif [ $# = 1 ]; then
  URL=$1
  shift;
fi

echo "using URL: $URL:$PORT"

echo "Usage: "
echo -e "\t# \t=> List Apps"
echo -e "\t- \t=> Volume Down"
echo -e "\t+ \t=> Volume Up"
echo -e "\tw|k \t=> cursor up"
echo -e "\ts|j \t=> cursor down"
echo -e "\td|l) \t=> cursor right"
echo -e "\ta|h) \t=> cursor left"
echo -e "\t<BS> \t=> back"
echo -e "\t<C-R> \t=> select"
echo -e "\t/ \t=> search"
echo -e "\ti \t=> info"
echo -e "\tp \t=> play"
echo -e "\t<Tab> \t=> play"
echo -e "\t~ \t=> home"
echo -e "\tq \t=> exit"

while read -n 1 key # 1 char (not delimiter), silent
do

  if [ "$key" = "#" ]; then
    curl "$URL:$PORT/query/apps"
    # | sed 's/^.*>([ a-zA-Z]+)<\/app>/\1/g'
  else
    case "$key" in

  ##    Rev
  ##    Fwd
  ##      InstantReplay
  ##      Backspace
  ##      Lit_

  ##      Play
  ##      Home
  ##      Info
  ##      Search
  ##      Select
  ##      Left
  ##      Right
  ##      Down
  ##      Up
  ##      Back
  ##      Enter

      t) # text field
        KEYPRESS='select'
        echo -e "\n\nStarting Text Field\n===================\n"
        while read -n 1 key # 1 char (not delimiter), silent
        do
          if [ "$key" = "\r\n" ]; then
            break
          else
            echo "$key"
            # curl -d "" "$URL:$PORT/keypress/Lit_$key"
          fi
        done
        echo $KEYPRESS
        ;;

      w|k)  # cursor up
        KEYPRESS='up'
        ;;

      s|j)  # cursor down
        KEYPRESS='down'
        ;;

      d|l)  # cursor right
        KEYPRESS='right'
        ;;

      a|h)  # cursor left
        KEYPRESS='left'
        ;;

      $'\177')
        KEYPRESS='back'
        ;;

      '')
        KEYPRESS='select'
        ;;

      '/')
        KEYPRESS='search'
        ;;

      i)
        KEYPRESS='info'
        ;;

      p)
        KEYPRESS='play'
        ;;

      '~')
        KEYPRESS='home'
        ;;

      =|+)
        KEYPRESS='volumeUp'
        ;;

      -|_)
        KEYPRESS='volumeDown'
        ;;

      \t)
        KEYPRESS='play'
        ;;

      q) # q, carriage return: quit
        echo "goodbye... for now!"
        exit 0;;

      *)
        echo "unknown key: $key"
        ;;

    esac
    curl -d "" "$URL:$PORT/keypress/$KEYPRESS"

  fi

done
