#!/data/data/com.termux/files/usr/bin/bash

# Lock Ctrl+C and Ctrl+Z
trap '' SIGINT SIGTSTP

# Colors
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Banner
clear
echo -e "${CYAN}"
figlet "VizXtreme"
echo -e "${RESET}"

# Paths
LOGIN_LOG="$HOME/.termux-login/login.log"
CRED_FILE="$HOME/.termux-login/creds.txt"

# Secret Bypass Hash 
SECRET_USER_HASH="Enter your hash here"

# Prompt for Username
read -p "Enter User ID: " input_user
input_user_hash=$(echo -n "$input_user" | openssl dgst -sha256 | awk '{print $2}')

# Bypass Check
if [[ "$input_user_hash" == "$SECRET_USER_HASH" ]]; then
    echo -e "${GREEN}Emergency Bypass Activated!${RESET}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | Emergency bypass by: $input_user" >> "$LOGIN_LOG"
    sleep 1
    exit 0
fi

# Prompt for Password
read -s -p "Enter Password: " input_pass
echo ""
input_pass_hash=$(echo -n "$input_pass" | openssl dgst -sha256 | awk '{print $2}')

# Validate creds.txt
if [[ ! -f "$CRED_FILE" ]]; then
    echo -e "${RED}Credential file missing!${RESET}"
    exit 1
fi

stored_user=$(sed -n '1p' "$CRED_FILE")
stored_pass_hash=$(sed -n '2p' "$CRED_FILE")

# Login Check
if [[ "$input_user" == "$stored_user" && "$input_pass_hash" == "$stored_pass_hash" ]]; then
    echo -e "${GREEN}Access Granted. Welcome, $input_user!${RESET}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | Login success: $input_user" >> "$LOGIN_LOG"
    sleep 1
else
    echo -e "${RED}Access Denied. Closing Termux...${RESET}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | Failed login attempt: $input_user" >> "$LOGIN_LOG"
    sleep 2
    pkill -9 -f com.termux
    exit 1
fi
