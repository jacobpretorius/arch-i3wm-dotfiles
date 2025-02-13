#!/bin/bash

# Send the header so that i3bar knows we want to use JSON:
echo '{"version":1}'

# Begin the endless array
echo '['

# Send an empty first array of blocks to make the loop simpler:
echo '[]'

# Function to escape JSON strings
escape_json() {
    echo "$1" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g'
}

# Now send blocks with information forever:
i3status | while :
do
    read line
    # Skip empty lines
    [[ -z "$line" ]] && continue
    
    # Get our custom info
    brightness=$(escape_json "$(/home/jacob/.config/i3status/scripts/brightness.sh)")
    volume=$(escape_json "$(/home/jacob/.config/i3status/scripts/volume.sh)")
    
    # Handle comma at start of line
    if [[ "${line:0:1}" = "," ]]; then
        line="${line:1}"
    fi
    
    # Log the line to /tmp for debugging
    #echo "$line" > /tmp/i3status_debug.log
    
    # Make sure we have valid JSON array content
    if [[ "$line" =~ ^\[.*\]$ ]]; then
        # Extract the content between [ and ]
        content="${line:1:-1}"
        # Output our combined JSON
        echo ",[{\"full_text\":\"$brightness\"},{\"full_text\":\"$volume\"},$content]"
    else
        # If we don't have valid JSON, output just our blocks
        echo ",[{\"full_text\":\"$brightness\"},{\"full_text\":\"$volume\"}]"
    fi
done
