#!/bin/bash

set -euo pipefail
shopt -s nullglob

cd /record/TV-Record

for file in *.ts; do
  export FileName="${file%.ts}"

  echo "Running RecEnd.sh for: ${FileName}"
  bash /app/RecEnd.sh || echo "ERROR: RecEnd.sh failed for: ${FileName}" >&2
done

echo "All tasks completed."