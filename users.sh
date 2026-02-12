#!/bin/bash

REPORT="$1"

echo "---- User & Privilege Policy ----" >> "$REPORT"

if [ ! -f /etc/passwd ]; then
    echo "User database not found." >> "$REPORT"
    return
fi

uid0=$(awk -F: '$3==0 {print $1}' /etc/passwd)

if [ "$uid0" = "root" ]; then
    echo "PASS: Only root has UID 0" >> "$REPORT"
else
    echo "WARN: Multiple UID 0 users:" >> "$REPORT"
    echo "$uid0" >> "$REPORT"
fi

empty_pw=$(awk -F: '($2==""){print $1}' /etc/shadow 2>/dev/null)

if [ -z "$empty_pw" ]; then
    echo "PASS: No empty password accounts" >> "$REPORT"
else
    echo "WARN: Empty password accounts found:" >> "$REPORT"
    echo "$empty_pw" >> "$REPORT"
fi

echo >> "$REPORT"
