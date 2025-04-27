mkdir -p $HOME/.termux-login

read -p "Enter new username: " USERNAME
read -s -p "Enter new password: " PASSWORD
echo ""
read -s -p "Confirm new password: " CONFIRM
echo ""

if [[ "$PASSWORD" != "$CONFIRM" ]]; then
    echo "Password mismatch!"
    exit 1
fi

HASHED_PASS=$(echo -n "$PASSWORD" | openssl dgst -sha256 | awk '{print $2}')

echo "$USERNAME" > $HOME/.termux-login/creds.txt
echo "$HASHED_PASS" >> $HOME/.termux-login/creds.txt

echo "Credentials set successfully!"
