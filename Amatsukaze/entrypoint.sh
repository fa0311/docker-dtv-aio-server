#!/bin/bash
set -euo pipefail

FLAG_FILE="/data/.done"

if [ -f "$FLAG_FILE" ]; then
  echo "[AmatsukazeSetup] Already done. Skipping."
  exit 0
fi

cp -r avs/* /data/avs
cp -r bat/* /data/bat
cp -r profile/* /data/profile
cp -r drcs/* /data/drcs
cp -r JL/* /data/JL

cp -r config/* /data/config || true
cp -r data/* /data/data || true
cp -r input/* /data/input || true
cp -r logo/* /data/logo || true
cp -r output/* /data/output || true

echo "[AmatsukazeSetup] Setup completed."
touch "$FLAG_FILE"