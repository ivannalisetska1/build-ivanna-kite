
# Check BUILDKITE_RETRY_COUNT at runtime
# Buildkite sets this variable automatically when a job is retried
# Check the variable directly - if it's unset or empty, default to 0
if [ -z "$BUILDKITE_RETRY_COUNT" ]; then
  RETRY_COUNT=0
else
  RETRY_COUNT="$BUILDKITE_RETRY_COUNT"
fi
echo "Retry count is: $RETRY_COUNT"

# Check if this is a retry (BUILDKITE_RETRY_COUNT will be 1 or higher)
if [ "$RETRY_COUNT" -eq 0 ]; then
  echo "Failing on first attempt on purpose."
  exit 1
fi

echo "This is a retry (attempt $RETRY_COUNT); passing now."
