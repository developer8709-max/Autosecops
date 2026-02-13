#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

REPORT_DIR="$BASE_DIR/reports"
mkdir -p "$REPORT_DIR"

TIME=$(date +"%Y%m%d_%H%M%S")
REPORT="$REPORT_DIR/autosecops_report_$TIME.txt"

echo "AutoSecOps – Linux Security Audit" > "$REPORT"
echo "Created by Murari Singh" >> "$REPORT"
echo "Date: $(date)" >> "$REPORT"
echo "----------------------------------" >> "$REPORT"

bash "$BASE_DIR/users.sh"     >> "$REPORT"
bash "$BASE_DIR/ssh.sh"       >> "$REPORT"
bash "$BASE_DIR/permission.sh" >> "$REPORT"
bash "$BASE_DIR/services.sh"  >> "$REPORT"

echo
echo "Report generated:"
echo "$REPORT"
