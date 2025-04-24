![License](https://img.shields.io/badge/license-MIT-green)

# FraudTagger Apple Mail Integration

This repository contains all you need to allows Apple Mail to automatically check incoming emails using the FraudTagger API and flag potential spam/machine generated email addresses in the sender field.

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

4. Edit the Applescript and insert your username in the line	- do shell script "/Users/YOURUSERNAME/bin/fraud_check.sh " & quoted form of senderEmail.
   
5. In Apple Mail:
   - Create a rule that runs the script for every message.
   - The rule will flag emails if the classification is "SPAM".
  
## API Key Usage

### Paid Access (With API Key)
The script by default uses a paid API key for access. You can set your own API key in the script by modifying the `API_KEY` variable:

```bash
API_KEY="YOUR_API_KEY_HERE"
```

### Free Tier Access (Without API Key)
You can test FraudTagger for free by commenting out the `API_KEY` variable:

```bash
#API_KEY="YOUR_API_KEY_HERE"
```
The API will allow a small number of checks per day (see latest website information or API response limits data for exact details)



## Notes

- The script logs API responses to `~/fraudtagger_log.txt`.
- Customize the AppleScript to move flagged messages to "Junk" if desired.



## 📄 Example API Response

This is a typical JSON response returned by the `fraud_check.sh` script and logged to `~/fraudtagger_log.txt`:

```json
{
  "metadata": {
    "name": "TQNN Fraud Tagger",
    "endpoint": "/v1/scoreUsername",
    "method": "GET",
    "randomness_range": "0-100",
    "entropy_range": "0-4",
    "confidence_range": "0-100",
    "request_id": "6809c744af0f2",
    "timestamp": 1745471300,
    "runtime_seconds": 3.5673,
    "verbose_mode": "yes",
    "called_by": "Unknown AI system",
    "energy": {
      "energy_usage_kWh": "0.0001684572",
      "carbon_emissions_mg": "39.2505169829",
      "equivalent_meters_driven": "0.3270876415"
    }
  },
  "data": {
    "email": "charlotteedwards451@gmail.com",
    "score": 6,
    "score_engine": "V1.0.4",
    "release": "Beta",
    "randomness": "85.27",
    "entropy": "3.41",
    "confidence": "72.63",
    "classification": "SPAM",
    "recommended_action": "quarantine or flag for further investigation",
    "reasoning": {
      "spam_lists_check": "NOT_EVALUATED",
      "similarity_to_known_spam": "Some similarity to known spam",
      "randomness_score": "The randomness is quite high at (85.27) which is unusual for real names and words",
      "entropy_score": "High Entropy (3.41) (Mostly Unpredictable)"
    }
  }
}
```
