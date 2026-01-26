#!/bin/bash
set -euo pipefail

# Determine retry count
RETRY_COUNT="${BUILDKITE_RETRY_COUNT:-0}"

echo "Retry count is: $RETRY_COUNT"

# First attempt: fail intentionally
if [ "$RETRY_COUNT" -eq 0 ]; then
  echo "Failing on first attempt on purpose."
  exit 1
fi

echo "This is a retry (attempt $RETRY_COUNT). Running 3 jobs in parallel..."

run_job() {
  JOB_NAME="$1"
  echo "Starting $JOB_NAME"

  # Simulate work — replace with real commands
  sleep $((RANDOM % 5 + 1))

  echo "$JOB_NAME finished successfully"
}

# Start jobs in background
run_job "Job-1" &
PID1=$!

run_job "Job-2" &
PID2=$!

run_job "Job-3" &
PID3=$!

# Wait for all jobs and capture failures
FAIL=0

for PID in $PID1 $PID2 $PID3; do
  if ! wait "$PID"; then
    FAIL=1
  fi
done

if [ "$FAIL" -ne 0 ]; then
  echo "One or more parallel jobs failed."
  exit 1
fi

echo "All parallel jobs completed successfully."
