# FraudTagger Apple Mail Integration

This repository allows Apple Mail to automatically check incoming emails using the FraudTagger API and flag potential spam.

## Components

- `fraud_check.sh`: A shell script that queries the FraudTagger API.
- `fraudtagger.scpt`: An AppleScript that integrates the shell script with Apple Mail.

## Setup Instructions

1. Copy `fraud_check.sh` to `~/bin/` and make it executable:
   ```bash
   chmod +x ~/bin/fraud_check.sh
   ```

2. Edit the script and insert your API key.

3. Copy `fraudtagger.scpt` to `~/Library/Application Scripts/com.apple.mail/`

4. In Apple Mail:
   - Create a rule that runs the script for every message.
   - The rule will flag emails if the classification is "SPAM".

## Notes

- The script logs API responses to `~/fraudtagger_log.txt`.
- Customize the AppleScript to move flagged messages to "Junk" if desired.
