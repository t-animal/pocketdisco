#!/bin/sh

cd "$(dirname "$0")"

gpio mode 7 input
gpio mode 8 output

gpio write 8 1
aplay dj-sets/party.wav

while true; do
	gpio write 8 0

	while [[ "$(gpio read 7)" != "0" ]]; do
		gpio wfi 7 falling
		sleep 0.1
	done	

	gpio write 8 1
	aplay dj-sets/current/$(ls -1 dj-sets/current/ | shuf -n 1)

	if [[ "$(gpio read 7)" == "0" ]]; then
		aplay dj-sets/poweroff.wav
		systemctl poweroff
	fi
done
