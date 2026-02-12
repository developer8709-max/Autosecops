#!/bin/bash

REPORT="$1"

echo "---- Critical File Permissions ----" >> "$REPORT"

check_perm() {

    file="$1"
    expected="$2"

    if [ ! -f "$file" ]; then
        echo "Missing: $file" >> "$REPORT"
        return
    fi

    perm=$(stat -c "%a" "$file")

    if [ "$perm" = "$expected" ]; then
        echo "PASS: $file ($perm)" >> "$REPORT"
    else
        echo "FAIL: $file expected $expected got $perm" >> "$REPORT"
    fi
}

check_perm /etc/passwd  "$PASSWD_PERM"
check_perm /etc/shadow  "$SHADOW_PERM"
check_perm /etc/sudoers "$SUDOERS_PERM"

echo >> "$REPORT"
