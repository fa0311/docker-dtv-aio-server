#!/bin/bash
#!_EDCBX_DIRECT_

set -euo pipefail

curl -X POST http://file-transfer-server:8080/transfer \
  -H "Content-Type: application/json" \
  -d "{\"source_path\":\"local:/TV-Record/${FileName}.ts\",\"dest_path\":\"peer:/TV-Record/${FileName}.ts\"}"
curl -X POST http://file-transfer-server:8080/transfer \
  -H "Content-Type: application/json" \
  -d "{\"source_path\":\"local:/TV-Record/${FileName}.ts.err\",\"dest_path\":\"peer:/TV-Record/${FileName}.ts.err\"}"
curl -X POST http://file-transfer-server:8080/transfer \
  -H "Content-Type: application/json" \
  -d "{\"source_path\":\"local:/TV-Record/${FileName}.ts.program.txt\",\"dest_path\":\"peer:/TV-Record/${FileName}.ts.program.txt\"}"

AmatsukazeAddTask -ip "192.168.70.2" -p 32768 -s "nvenc" -f "/record/TV-Record/${FileName}.ts" -o "/record/TV-Encode"

rm -f "/record/TV-Record/${FileName}.ts"
rm -f "/record/TV-Record/${FileName}.ts.err"
rm -f "/record/TV-Record/${FileName}.ts.program.txt"