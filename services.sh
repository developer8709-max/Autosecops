##!/bin/bash

echo
echo "=== Insecure Service Check ==="

if ! command -v systemctl >/dev/null 2>&1; then
    echo "systemctl not available on this system"
    exit 0
fi

for svc in telnet ftp rsh
do
    if systemctl list-unit-files | grep -q "^$svc"; then
        STATE=$(systemctl is-enabled "$svc" 2>/dev/null)
        echo "$svc service: $STATE"
    else
        echo "$svc service: not installed"
    fi
done
