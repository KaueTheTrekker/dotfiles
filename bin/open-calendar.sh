#!/bin/sh

gsimplecal &

# let the window open
while [ $(xdotool search --class Gsimplecal | wc -l) -lt 2 ]; do
  sleep 0.01
done

screen_width=$(xrandr | grep current | sed -r 's/^.*current ([0-9]+).*/\1/')
x_pos=$(( screen_width - 620 ))
y_pos=38

i3-msg "[class=\"Gsimplecal\"] move absolute position $x_pos $y_pos"