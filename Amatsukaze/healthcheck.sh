#!/bin/bash
set -euo pipefail

UUID=$(cat /proc/sys/kernel/random/uuid)
CMD="./exe_files/AmatsukazeAddTask -ip 127.0.0.1 --item-id doesnotexist-$UUID"
TIMEOUT=2
MSG="指定されたアイテムが見つかりません"

OUTPUT=$(timeout "$TIMEOUT" $CMD 2>&1) || exit 1
grep -q "$MSG" <<<"$OUTPUT" && echo "OK" || echo "NG"
