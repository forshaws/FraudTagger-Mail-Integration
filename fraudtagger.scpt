using terms from application "Mail"
    on perform mail action with messages theMessages for rule theRule
        tell application "Mail"
            repeat with aMessage in theMessages
                set senderEmail to extract address from sender of aMessage
                try
                    do shell script "/Users/YOUR_USERNAME/bin/fraud_check.sh " & quoted form of senderEmail
                on error
                    -- If script exits with error (exit code 1), flag or move the email
                    set flagged status of aMessage to true
                end try
            end repeat
        end tell
    end perform mail action with messages
end using terms from
