#!/usr/bin/env bash
set -euo pipefail

# Add a little jitter so runs don't finish at exactly the same time
sleep $((RANDOM % 5))

# 0,1,2 → pass only on 0 (≈33% chance)
if (( RANDOM % 3 == 0 )); then
  echo "🎉 This shard passed on agent ${BUILDKITE_AGENT_NAME:-unknown}"
  buildkite-agent meta-data set flaky_ok true
  exit 0
else
  echo "💥 This shard failed on agent ${BUILDKITE_AGENT_NAME:-unknown}"
  exit 1
fi
