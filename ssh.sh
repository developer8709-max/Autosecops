#!/bin/bash

echo
echo "=== SSH Hardening Check ==="

FILE="/etc/ssh/sshd_config"

if [ ! -f "$FILE" ]; then
    echo "SSH config not found"
    exit 0
fi

ROOT_LOGIN=$(grep -i "^PermitRootLogin" "$FILE" | tail -n 1 | awk '{print $2}')
PASS_AUTH=$(grep -i "^PasswordAuthentication" "$FILE" | tail -n 1 | awk '{print $2}')

echo "PermitRootLogin: ${ROOT_LOGIN:-not set}"
echo "PasswordAuthentication: ${PASS_AUTH:-not set}"

if [ "$ROOT_LOGIN" = "yes" ]; then
    echo "WARN: Root login over SSH enabled"
else
    echo "PASS: Root login disabled or not set"
fi
