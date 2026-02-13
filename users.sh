#!/bin/bash

echo
echo "=== User & Privilege Check ==="

COUNT=$(awk -F: '$3==0{print $1}' /etc/passwd | wc -l)

echo "UID 0 users count: $COUNT"

if [ "$COUNT" -gt 1 ]; then
    echo "WARN: More than one root-level account exists"
else
    echo "PASS: Only one root-level account"
fi
