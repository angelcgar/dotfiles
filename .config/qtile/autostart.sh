#!/bin/sh

# systray battery icon
cbatticon -u 5 &
# systray volume
volumeicon &
# systray internet
nm-applet &
# systray discos
udiskie -t &
# picom
picom &
