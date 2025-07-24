#!/bin/bash

echo "--- Linux Flavour Check ---"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "OS: $PRETTY_NAME"
elif [ -f /etc/redhat-release ]; then
    echo "OS: $(cat /etc/redhat-release)"
elif [ -f /etc/issue ]; then
    echo "OS: $(head -n 1 /etc/issue)"
else
    echo "Could not determine OS flavour."
fi

echo -e "\n--- Current Logged-in Users ---"
who -H

echo -e "\n--- Internet Access Check ---"
# We'll try to ping a well-known public DNS server (Google's 8.8.8.8)
# and a common website (google.com) to test both IP and DNS resolution.
PING_TARGET_IP="8.8.8.8"
PING_TARGET_DOMAIN="google.com"
PING_COUNT=2 # Number of pings to send

echo "Attempting to ping $PING_TARGET_IP..."
if ping -c $PING_COUNT $PING_TARGET_IP &> /dev/null; then
    echo "Successfully pinged $PING_TARGET_IP. IP connectivity appears to be working."
else
    echo "Could not ping $PING_TARGET_IP. IP connectivity may be limited or absent."
fi

echo "Attempting to ping $PING_TARGET_DOMAIN..."
if ping -c $PING_COUNT $PING_TARGET_DOMAIN &> /dev/null; then
    echo "Successfully pinged $PING_TARGET_DOMAIN. DNS resolution and internet access appear to be working."
else
    echo "Could not ping $PING_TARGET_DOMAIN. DNS resolution or internet access may be limited or absent."
    echo "If IP connectivity worked, check your DNS settings (e.g., /etc/resolv.conf)."
fi

echo -e "\n--- Script Complete ---"
