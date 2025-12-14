#!/bin/sh
set -eu

OUT_DIR="${OUT_DIR:-/out}"
mkdir -p "$OUT_DIR"

KEY_PATH="$OUT_DIR/reverse-proxy.key"
CRT_PATH="$OUT_DIR/reverse-proxy.crt"

if [ -f "$KEY_PATH" ] && [ -f "$CRT_PATH" ]; then
  echo "Certificates already exist in $OUT_DIR, skipping generation."
  exit 0
fi

openssl req \
  -newkey rsa:2048 -nodes -x509 \
  -days 36500 \
  -keyout "$KEY_PATH" \
  -out "$CRT_PATH" \
  -config /certs/san.cnf

