#!/bin/sh

cd "$(dirname "$0")"

gpio mode 8 output
gpio mode 7 input

pulseaudio -D
PULSE_PID=$!

cvlc --play-and-exit -Z party.mp3

while true; do
	gpio write 8 0

	#VLC stutters in the beginning -> prepend 1s silence. play half of that now.
	cvlc --play-and-exit -Z $(ls -x | grep short.mp3 | shuf -n 1)  & 
	VLC_PID=$!
	sleep 0.5
	kill -s STOP $VLC_PID
	
	gpio wfi 7 falling
	gpio write 8 1
	sleep 0.25

	kill -s CONT $VLC_PID
	wait
	sleep 0.5

	if [[ "$(gpio read 7)" == "0" ]]; then
		sudo systemctl poweroff;
		cvlc --play-and-exit -Z poweroff.mp3
	fi
done

kill $PULSE_PID
