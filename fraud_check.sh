#!/bin/bash

# The email address to check is passed as the first argument to the script
EMAIL="$1"

# API key is required for paid access. If you want to use the free tier (10 requests per day),
# you can COMMENT OUT the line below and the API will work without an API key.
API_KEY="your_api_key_here"  # <-- To disable, comment out this line


# Modify the API URL based on whether you are using the free tier or the API key version.
# If using the free tier, the URL will not include the &apikey query parameter.
if [ -z "$API_KEY" ]; then
    # No API key, free tier access
    API_URL="https://api.toridion.com/v1/scoreUsername/?email=$EMAIL"
else
    # API key provided, paid access
    API_URL="https://api.toridion.com/v1/scoreUsername/?email=$EMAIL&apikey=$API_KEY"
fi

# Path to store the temporary response from the API
TMPFILE="/tmp/fraudtagger_response.json"

# Call the API and write the response to the temporary file.
curl -s "$API_URL" > "$TMPFILE"

# Log the full response to a log file for reference
cat "$TMPFILE" >> ~/fraudtagger_log.txt
echo -e "\n--------------------------\n" >> ~/fraudtagger_log.txt

# Safely extract the 'classification' field from the JSON response
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

# Exit based on the classification value
# If the classification is "SPAM", the script exits with status code 1
if [ "$CLASS" = "SPAM" ]; then
    exit 1
else
    exit 0
fi
