#!/bin/bash
set -euo pipefail

curl -fsS -m 2 -o /dev/null http://127.0.0.77:7010/api/version?healthcheck || exit 1