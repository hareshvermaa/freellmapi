#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
LOG_FILE=/tmp/freellmapi-codespaces.log

if curl --silent --fail http://127.0.0.1:3001/api/ping >/dev/null 2>&1 && curl --silent --fail http://127.0.0.1:5173/ >/dev/null 2>&1; then
  echo "FreeLLMAPI is already running."
  exit 0
fi

nohup npm run dev:lan >"$LOG_FILE" 2>&1 </dev/null &
echo "Starting FreeLLMAPI; startup log: $LOG_FILE"

for attempt in $(seq 1 60); do
  if curl --silent --fail http://127.0.0.1:3001/api/ping >/dev/null 2>&1 && curl --silent --fail http://127.0.0.1:5173/ >/dev/null 2>&1; then
    echo "FreeLLMAPI is ready. Dashboard: forwarded port 5173; API: forwarded port 3001."
    exit 0
  fi
  sleep 2
done

echo "FreeLLMAPI did not become healthy within 120 seconds. Recent log:"
tail -n 80 "$LOG_FILE" || true
exit 1
