#!/bin/sh
curl -fsS -m 2 -o /dev/null http://127.0.0.1:5510/EMWUI/epgweek.html?healthcheck || exit 1