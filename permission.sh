#!/bin/bash

echo
echo "=== Critical File Permission Check ==="

check_file() {
    if [ -f "$1" ]; then
        echo "$1 -> $(stat -c %A "$1")"
    else
        echo "$1 -> file not found"
    fi
}

check_file /etc/passwd
check_file /etc/shadow
check_file /etc/sudoers
