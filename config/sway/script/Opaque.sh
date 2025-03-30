#!/run/current-system/sw/bin/bash

# Get the ID of the currently focused window
id=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .id')

# Define a temporary file to store opacity states
state_file="/tmp/sway_opacity_$id"

# Check if the file exists and read the last stored opacity
if [[ -f "$state_file" ]]; then
    last_opacity=$(cat "$state_file")
else
    last_opacity="1.0"  # Default to fully visible
fi

# Toggle opacity between 1 and 0.5
if [[ "$last_opacity" == "0.8" ]]; then
    new_opacity="1.0"
else
    new_opacity="0.8"
fi

# Apply the new opacity
swaymsg "[con_id=$id] opacity $new_opacity"

# Store the new opacity state
echo "$new_opacity" > "$state_file"

