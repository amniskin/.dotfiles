#!/usr/bin/env bash

if synclient -l | grep "TouchpadOff .*=.*0" ; then
	synclient TouchpadOff=1;
	#xinput enable 11 ;
else
	synclient TouchpadOff=0;
	#xinput disable 11 ;
fi


#if xinput list-props 11 | grep "Device Enabled .* 0" ; then
#	xinput disable 11 ;
#else
#	xinput enable 11;
#fi
