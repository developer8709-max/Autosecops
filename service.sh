#!/bin/bash

REPORT="$1"

echo "---- Unwanted Services ----" >> "$REPORT"

check_service() {

    svc="$1"
    allowed="$2"

    if ! command -v systemctl >/dev/null; then
        echo "systemctl not available." >> "$REPORT"
        return
    fi

    if systemctl list-unit-files | grep -q "^$svc"; then
        if [ "$allowed" = "no" ]; then
            echo "WARN: $svc service exists on system" >> "$REPORT"
        else
            echo "INFO: $svc present (allowed)" >> "$REPORT"
        fi
    else
        echo "PASS: $svc not present" >> "$REPORT"
    fi
}

check_service telnet.service "$CHECK_TELNET"
check_service ftp.service    "$CHECK_FTP"
check_service rsh.service    "$CHECK_RSH"

echo >> "$REPORT"
