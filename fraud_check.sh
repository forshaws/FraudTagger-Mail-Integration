#!/bin/bash

EMAIL="$1"
API_KEY="your_api_key_here"
API_URL="https://api.toridion.com/v1/scoreUsername/"
TMPFILE="/tmp/fraudtagger_response.json"

# Call the API and write response to file
curl -s "$API_URL?email=$EMAIL&apikey=$API_KEY" > "$TMPFILE"

# Log full response
cat "$TMPFILE" >> ~/fraudtagger_log.txt
echo -e "\n--------------------------\n" >> ~/fraudtagger_log.txt

# Safely extract classification from file
CLASS=$(python3 <<EOF
import json
try:
    with open("$TMPFILE") as f:
        data = json.load(f)
        print(data.get('data', {}).get('classification', 'UNKNOWN'))
except Exception:
    print("UNKNOWN")
EOF
)

# Exit based on classification
if [ "$CLASS" = "SPAM" ]; then
    exit 1
else
    exit 0
fi
