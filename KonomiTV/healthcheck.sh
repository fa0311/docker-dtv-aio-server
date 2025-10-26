#!/bin/sh
curl -fsS -m 2 -o /dev/null http://127.0.0.77:7010/api/version || exit 1