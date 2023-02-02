#!/bin/sh
# adapted from from https://sylvaindurand.org/dynamic-wallpapers-with-sway/

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
		swaybg -i $(find ~/Pictures/wallpapers/paintings/*/*.{png,jpg} -type f | shuf -n1) -m fill &
		OLD_PID=$!
		while true; do
				sleep 600
				swaybg -i $(find ~/Pictures/wallpapers/paintings/*/*.{png,jpg} -type f | shuf -n1) -m fill &
				NEXT_PID=$!
				sleep 5
				kill $OLD_PID
				OLD_PID=$NEXT_PID
		done
else
		feh --bg-fill $(find ~/Pictures/wallpapers/paintings/*/*.{png,jpg} -type f | shuf -n1) &
		OLD_PID=$!
		while true; do
				sleep 600
				feh --bg-fill $(find ~/Pictures/wallpapers/paintings/*/*.{png,jpg} -type f | shuf -n1) &
				NEXT_PID=$!
				sleep 5
				kill $OLD_PID
				OLD_PID=$NEXT_PID
		done
fi


