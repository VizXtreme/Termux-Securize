# Termux Securize

A secure login system for **Termux** that protects access using encrypted credentials, login tracking, and emergency bypass support. Designed with security and flexibility in mind.

## Features

### 1. Encrypted Username & Password Authentication

- User credentials are stored securely.

- Passwords are hashed using SHA-256 via openssl before saving or checking.

- Ensures credentials cannot be read directly from the storage file.

---
### 2. Emergency Unlock Using a Secret Username

- If you forget your credentials, entering a predefined emergency username will bypass the lock.

- This username is also stored and compared securely using hashing.

- Helps in recovery without needing to delete the script manually.

---

### 3. Login Log Tracking

- All login attempts are logged in login.log.

- Each entry includes:

    - Timestamp

    - Input username

    - Result (Success or Failed)


- Helps track unauthorized or failed login attempts.

---

### 4. ASCII Banner Using Figlet

- Displays a stylized terminal banner at login using figlet.

- Makes the login prompt visually distinct and stylish.

- Enhances branding or personalization.

---

### 5. Ctrl+C / Ctrl+Z Protection

Prevents bypassing the login screen using keyboard interrupts like:

- Ensures the login script can’t be force-terminated by the user.

    - `Ctrl+C (SIGINT)`
    - `CTRL+V (SIGTSTP)`


---

### 6. Modular Scripts

- Main login handled by login.sh

- Credential management handled by change-creds.sh

- Keeps code organized and easier to maintain or upgrade.

---
## Installation Guide

### 1. Clone the Repository

```bash
git clone https://github.com/VizXtreme/termux-securize && cd termux-securize
```

### 2. Install Dependencies

```bash
pkg update && pkg install openssl openssl-tool figlet -y
```

### 3. Create Required Directory

```bash
mkdir -p ~/.termux-login
```

### 4. Copy Scripts

```bash
cp login.sh change-creds.sh setup-creds.sh ~/.termux-login/
chmod +x ~/.termux-login/*.sh && cd
```

### 5. Add Auto-login Hook

Append this line at the top of `~/.bashrc`:

```bash
[ -f "$HOME/.termux-login/login.sh" ] && bash "$HOME/.termux-login/login.sh"
```

> **Note**: Restart Termux or run `source ~/.bashrc` to test.

---

## Usage

### Setup Credentials

Run the credential changer script:

```bash
bash ~/.termux-login/setup-creds.sh
```

Follow the prompt to set a new username and password. Your password will be hashed using **SHA-256** and stored securely in `~/.termux-login/creds.txt`.

### Emergency Bypass

If you forget your credentials, enter your **emergency username** (hashed internally) to unlock access.

Refer to [Emergency Bypass](https://github.com/VizXtreme/Termux-Securize/blob/main/Emergency-Bypass-Setup.md) to set it up.


### Credential Format

`creds.txt` contains:
```
USERNAME (plain)
PASSWORD_HASH (SHA256)
```

---

## Logging

All login attempts are saved in:

```bash
~/.termux-login/login.log
```

With timestamps, success/failure status, and the user entered.

---

## Contribution

Feel free to contribute or suggest improvements via [issues](https://github.com/VizXtreme/termux-securize/issues).

---

## License

MIT License
