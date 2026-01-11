#!/usr/bin/env bash
set -e

# Simple cron wrapper to run updateDb.py
# - Resolves paths relative to this script
# - Uses python3 by default (override with PYTHON_BIN)
# - Logs to a file in this same folder

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_BIN="${PYTHON_BIN:-python3}"
LOG_FILE="$SCRIPT_DIR/updateTRMNL_Db.log"

echo "[$(date -Is)] Starting updateDb.py" >> "$LOG_FILE"

if command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  "$PYTHON_BIN" "$SCRIPT_DIR/updateDb.py" >> "$LOG_FILE" 2>&1
  STATUS=$?
else
  echo "[$(date -Is)] ERROR: $PYTHON_BIN not found in PATH" >> "$LOG_FILE"
  STATUS=127
fi

echo "[$(date -Is)] Finished with status $STATUS" >> "$LOG_FILE"
exit $STATUS

