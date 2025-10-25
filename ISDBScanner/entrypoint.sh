#!/usr/bin/env bash
set -euo pipefail

FLAG_FILE="/app/Scanned/.done"

if [ -f "$FLAG_FILE" ]; then
  echo "[ISDBScanner] Already done. Skipping."
  exit 0
fi


echo "[ISDBScanner] Starting initial scan..."
python3 -m isdb_scanner --list-tuners


if [ "${EXCLUDE_PAY_TV:-0}" = "1" ]; then
  echo "[ISDBScanner] Excluding pay TV channels."
  python3 -m isdb_scanner --exclude-pay-tv ./Scanned/
else
  echo "[ISDBScanner] Including pay TV channels."
  python3 -m isdb_scanner ./Scanned/
fi

echo "[ISDBScanner] Initial scan completed."


touch "$FLAG_FILE"
