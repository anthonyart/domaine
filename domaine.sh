# Domaine - domain vitals checker | v1.0 | @anthonyart
#!/bin/bash
# Check internet connection by pinging Google
echo "Checking internet connection..."
ping -c 1 google.com &> /dev/null
if [ $? -ne 0 ]; then
    echo "No internet connection. Please check your network and try again."
    exit 1
fi

# Prompt user for the domains to check (space-separated)
read -p "Enter the domain names (e.g., google apple meta): " -a DOMAINS

# Loop over each domain in the array
for DOMAIN in "${DOMAINS[@]}"; do
    # If no TLD is provided, append .com
    if [[ ! $DOMAIN =~ \. ]]; then
        DOMAIN="${DOMAIN}.com"
    fi

    echo "Checking domain: $DOMAIN"
    echo "Connecting..."

    # Retry mechanism for transient errors with a 10-second timeout
    ATTEMPTS=3
    SUCCESS=0

    for (( i=1; i<=$ATTEMPTS; i++ )); do
        if [ $i -gt 1 ]; then
            echo "Retrying... (Attempt $i of $ATTEMPTS)"
        fi

        # Check if the website is online using curl with a timeout
        HTTP_STATUS=$(curl -Is -L --insecure --max-time 10 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
        -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" \
        -H "Accept-Language: en-US,en;q=0.5" https://$DOMAIN 2>&1)

        # Check if the website is online
        if echo "$HTTP_STATUS" | grep -q "200\|301\|302"; then
            SUCCESS=1
            echo "Website is online."
            break
        fi

        # Short delay before retrying
        sleep 1
    done

    if [ $SUCCESS -ne 1 ]; then
        echo "Website is offline or inaccessible due to timeout or other issue."
        echo "$HTTP_STATUS"  # Output the full response for debugging
    fi

    echo "Checking HTTPS status..."
    if echo "$HTTP_STATUS" | grep -q "200\|301"; then
        echo "HTTPS is enabled and the website is secure."
    else
        echo "HTTPS is not enabled or the website is not secure."
    fi

    echo "Checking MX records..."
    MX_RECORDS=$(dig +short MX $DOMAIN)
    if [ -n "$MX_RECORDS" ]; then
        echo "Mail server is set up:"
        echo "$MX_RECORDS"
    else
        echo "No mail server found for $DOMAIN."
    fi

    echo "Checking domain expiration..."
    EXPIRATION_DATE=$(whois $DOMAIN | grep -i "Expiration Date" | head -n 1 | awk '{print $NF}')
    if [ -n "$EXPIRATION_DATE" ]; then
        echo "Domain expires on: $EXPIRATION_DATE"
    else
        echo "Unable to retrieve domain expiration date."
    fi

    echo "----------------------------------" # Divider for readability between domain checks
done
