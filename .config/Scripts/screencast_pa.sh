#!/bin/bash

#This is the ffmpeg command that the screencast shortcut in i3 will run.

#Picks a file name for the output file based on availability:

if [[ -f ~/output.mkv ]]
	then
		n=1
		while [[ -f ~/output_$n.mkv ]]
		do	
			n=$((n+1))
		done
		filename="output_$n.mkv"
	else
		filename="output.mkv"
fi

#The actual ffmpeg command:

ffmpeg -y \
-f x11grab \
-s $(xdpyinfo | grep dimensions | awk '{print $2;}') \
-i :0.0 \
 -f pulse -ac 1 -ar 44100 -i alsa_input.usb-Blue_Microphones_Yeti_Stereo_Microphone_REV8-00.analog-stereo \
 -c:v libx264 -r 30 -c:a flac $filename
 #-c:v ffvhuff -r 30 -c:a flac $filename
