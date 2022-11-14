#!/bin/sh
# from https://sylvaindurand.org/dynamic-wallpapers-with-sway/
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
