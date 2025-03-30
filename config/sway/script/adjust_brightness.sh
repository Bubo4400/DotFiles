#!/run/current-system/sw/bin/bash
if [ "$1" == "up" ]; then
  light -A 10
elif [ "$1" == "down" ]; then
  light -U 10
fi
