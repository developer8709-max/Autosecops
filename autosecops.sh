#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
REPORT="$BASE_DIR/reports/report-$(date +%F_%H%M%S).txt"

mkdir -p "$BASE_DIR/reports"

source "$BASE_DIR/baseline/baseline.conf"

echo "========================================" > "$REPORT"
echo " AutoSecOps Compliance Report"          >> "$REPORT"
echo "  Created by Murari Singh"               >> "$REPORT"
echo "========================================" >> "$REPORT"
echo "Date: $(date)"                          >> "$REPORT"
echo                                        >> "$REPORT"

for m in users ssh permissions services
do
    if [ -f "$BASE_DIR/modules/$m.sh" ]; then
        bash "$BASE_DIR/modules/$m.sh" "$REPORT"
    fi
done

echo >> "$REPORT"
echo "Compliance scan finished." >> "$REPORT"

echo
echo "Report generated:"
echo "$REPORT"
