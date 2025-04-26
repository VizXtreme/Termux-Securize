# Option to change credentials
read -p "Do you want to change credentials? (y/N): " change_creds
if [[ "$change_creds" =~ ^[Yy]$ ]]; then
    echo -e "${CYAN}"
    figlet "Change Credentials"
    echo -e "${RESET}"
    
    read -p "Enter new User ID: " new_user
    read -s -p "Enter new Password: " new_pass
    echo ""

    new_pass_hash=$(echo -n "$new_pass" | openssl dgst -sha256 | awk '{print $2}')
    echo "$new_user:$new_pass_hash" > "$CREDENTIALS_FILE"
    echo -e "${GREEN}Credentials updated successfully.${RESET}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | User: $input_user | Changed credentials" >> "$LOGIN_LOG"
    exit
fi
