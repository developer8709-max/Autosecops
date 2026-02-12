#!/bin/bash

REPORT="$1"
CFG="/etc/ssh/sshd_config"

echo "---- SSH Policy ----" >> "$REPORT"

if [ ! -f "$CFG" ]; then
    echo "SSH config not found." >> "$REPORT"
    echo >> "$REPORT"
    exit 0
fi

root_login=$(grep -Ei "^PermitRootLogin" "$CFG" | tail -1 | awk '{print $2}')
pass_auth=$(grep -Ei "^PasswordAuthentication" "$CFG" | tail -1 | awk '{print $2}')

if [ "$ALLOW_ROOT_SSH" = "no" ] && [ "$root_login" = "yes" ]; then
    echo "FAIL: Root SSH login is enabled" >> "$REPORT"
else
    echo "PASS: Root SSH policy OK" >> "$REPORT"
fi

if [ "$ALLOW_PASSWORD_AUTH" = "no" ] && [ "$pass_auth" = "yes" ]; then
    echo "FAIL: SSH password authentication enabled" >> "$REPORT"
else
    echo "PASS: SSH password auth policy OK" >> "$REPORT"
fi

echo >> "$REPORT"
