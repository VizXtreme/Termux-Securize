# Emergency Unlock (Bypass) Setup

This system allows you to regain access to Termux if you forget your username or password by using a secret unlock method.

## How It Works

- When the login script asks for **User ID**, you can type your secret emergency username.
- If it matches the hidden hash inside the script, you will immediately unlock Termux without a password.
- This method is fully encrypted (SHA-256 based).

## Steps to Setup Emergency Unlock

1. **Choose a secret emergency username.**  
   Example: `unlockme`

2. **Generate a SHA-256 hash of your secret username.**

   Run this command in Termux:

   ```bash
   echo -n "your-secret-username" | openssl dgst -sha256
   ```

   Example:

   ```bash
   echo -n "unlockme" | openssl dgst -sha256
   ```

   You will get an output like:

   ```
   (stdin)= e10adc3949ba59abbe56e057f20f883e
   ```

3. **Copy the generated hash.**

4. **Edit your `login.sh` file** in ~/.termux-login/

   In line no. 23:

   ```bash
   SECRET_USER_HASH="your_encrypted_secret_hash_here"
   ```

   Replace `your_encrypted_secret_hash_here` with your actual hash (without spaces).

   Example:

   ```bash
   SECRET_USER_HASH="e10adc3949ba59abbe56e057f20f883e"
   ```

5. **Save and exit.**

## How to Use Emergency Unlock

- When Termux starts and asks for **User ID**,  
  enter your emergency username (the one you chose, e.g., `unlockme`).
- Leave the password blank (just press Enter).
- Access will be granted immediately if the username matches the hidden secret hash.

## Important Notes

- Your emergency username is case-sensitive.
- Anyone knowing the secret username can unlock your Termux, so keep it secure.
- This is intended only for recovery purposes.
