# Domaine
Quickly check if multiple domains are live and secure from command line

---

# What it Do

This Bash script allows you to quickly check the vital stats for multiple domain names. With a focus on speed it enables you to see if a website is online, secure, has active mail servers etc. with a single command. 

## Features

- **Internet Connection Check**: Ensures there is an active internet connection before proceeding.
- **Domain Status Check**: Verifies if a website is online and accessible, following redirects as necessary.
- **HTTPS Verification**: Confirms if the website supports HTTPS and is secure.
- **Mail Server (MX Record) Check**: Checks if MX records are set up for the domain, indicating active mail servers.
- **Domain Expiration Check**: Retrieves the domain expiration date from WHOIS data.
- **Multiple Domain Input**: Accepts multiple domains separated by spaces for batch processing.
- **Automatic `.com` Addition**: If no TLD is provided, `.com` is assumed by default.
- **Retry Mechanism**: Attempts to connect up to three times for domains that are temporarily inaccessible.
- **Connection Timeout**: Automatically times out connections after 10 seconds to avoid delays from unresponsive domains.
- **User-Friendly Status Updates**: Provides feedback at each step with messages like ["Connecting...", "Retrying...", "Checking MX..."].
- **Enhanced Header Simulation**: Uses browser-like headers to improve server compatibility.

### Planned Features
- **Feature #6**: Investigate Bug #6 which affects some domains that appear online in browsers but are flagged as offline by the script. Testing with a VPN or proxy could help diagnose network-specific issues.
- **Feature #? - Resolve MX Record Owner**: Add support to identify the owner of the MX records. For example, "Namecheap.com" as the owner of "jellyfish.systems" and "registrar-servers.com."

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/anthonyart/domaine.git
   cd domaine
   ```

2. Make the script executable:
   ```bash
   chmod +x domaine.sh
   ```

## Usage

To run the script, enter the following command and specify the domains you wish to check:

```bash
./domaine.sh
```

When prompted, enter one or more domain names separated by spaces (e.g., `google amazon apple`). The script will automatically add `.com` if no TLD is provided.

### Example
```bash
Enter the domain names (e.g., google amazon apple): google amazon apple
```

### Sample Output
```
Checking domain: google.com
Connecting...
Website is online.
Checking HTTPS status...
HTTPS is enabled and the website is secure.
Checking MX records...
Mail server is set up:
10 smtp.google.com.
Checking domain expiration...
Domain expires on: 2028-09-13T07:00:00+0000
----------------------------------
```

## Troubleshooting

- If you encounter **timeouts or repeated offline statuses**, check your network connection or consider using a VPN/proxy to see if the issue is network-specific.
- If the **script hangs** due to a non-responsive domain, the 10-second timeout will help prevent extended delays.
  
## Contributing

Fork it, then add any Issues. Delicious.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---
