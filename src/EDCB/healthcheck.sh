#!/bin/sh
set -euo pipefail

curl -fsS -m 2 -o /dev/null http://127.0.0.1:5510?healthcheck || exit 1