#!/data/data/com.termux/files/usr/bin/bash

CRED_FILE="$HOME/.termux-login/creds.txt"
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"

echo -e "${CYAN}:: Termux Credential Changer ::${RESET}"

# Check if credentials exist
if [[ ! -f "$CRED_FILE" ]]; then
    echo -e "${RED}Error: Credential file not found. Run the login script first.${RESET}"
    exit 1
fi

# Read stored credentials
read -r STORED_USER < "$CRED_FILE"
read -r STORED_PASS_HASH < <(sed -n 2p "$CRED_FILE")

# Ask for old password
read -s -p "Enter old password: " OLD_PASS
echo ""
OLD_PASS_HASH=$(echo -n "$OLD_PASS" | openssl dgst -sha256 | awk '{print $2}')

# Validate password
if [[ "$OLD_PASS_HASH" != "$STORED_PASS_HASH" ]]; then
    echo -e "${RED}Incorrect old password. Aborting.${RESET}"
    exit 1
fi

# Ask for new username and password
read -p "Enter new username: " NEW_USER
read -s -p "Enter new password: " NEW_PASS
echo ""
read -s -p "Confirm new password: " CONFIRM_PASS
echo ""

if [[ "$NEW_PASS" != "$CONFIRM_PASS" ]]; then
    echo -e "${RED}Password mismatch. Aborting.${RESET}"
    exit 1
fi

# Hash new password
NEW_PASS_HASH=$(echo -n "$NEW_PASS" | openssl dgst -sha256 | awk '{print $2}')

# Store credentials
echo "$NEW_USER" > "$CRED_FILE"
echo "$NEW_PASS_HASH" >> "$CRED_FILE"

echo -e "${GREEN}Credentials updated successfully.${RESET}"
