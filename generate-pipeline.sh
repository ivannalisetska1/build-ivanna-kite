d#!/usr/bin/env bash
cat <<'YAML' | buildkite-agent pipeline upload
steps:
  - label: "Deploy A (sleep 60s)"
    command: 'echo "A start"; date; sleep 60; echo "A done"; date'

  - label: "Deploy B (sleep 30s)"
    command: 'echo "B start"; date; sleep 30; echo "B done"; date'
YAML
