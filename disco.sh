#!/bin/bash

if [[ "$(groups | grep -E 'audio|root')" == "" ]]; then
	echo "Must be root or in the 'audio' group";
	exit 1;
fi

echo "Starting up"

cd "$(dirname "$0")"

gpio mode 7 input
gpio mode 8 output

echo "GPIO pins set up"

gpio write 8 1
aplay dj-sets/party.wav

echo "Played startup sound"

while true; do
	gpio write 8 0

	while [[ "$(gpio read 7)" != "0" ]]; do
		gpio wfi 7 falling
		sleep 0.1
	done	

	echo "Detected button press"

	gpio write 8 1
	sleep 0.1

	song="$(find dj-sets/current/ -maxdepth 1 -type f -regex '.*wav' | shuf -n 1)"
	echo "Randomly selected $song"

	aplay $song
	echo "Played song"

	if [[ "$(gpio read 7)" == "0" ]]; then
		aplay dj-sets/poweroff.wav
		systemctl poweroff
	fi
done
