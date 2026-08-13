#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

# Accept URL from first argument or ENDPOINT_URL environment variable
URL="https://workstation-58.sdu.eficode.academy/proxy/8080"
TIMEOUT="${TIMEOUT:-10}" # Default 10-second timeout

if [ -z "$URL" ]; then
  echo "❌ ERROR: No target URL provided."
  echo "Usage: ./test-endpoint.sh"
  exit 1
fi

echo "🔍 Checking endpoint: $URL..."

# Make request and capture HTTP status code
# -s  : Silent mode (hides progress meter)
# -S  : Show error message if curl fails
# -o  : Redirect response body to /dev/null
# -w  : Print custom output (HTTP status code)
# -m  : Maximum time in seconds allowed for the transfer
HTTP_STATUS=$(curl -sS -o /dev/null -w "%{http_code}" -m "$TIMEOUT" "$URL" || echo "000")

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "✅ SUCCESS: Endpoint returned HTTP 200 OK"
  exit 0
else
  echo "❌ FAILURE: Endpoint returned HTTP $HTTP_STATUS (Expected 200)"
  exit 1
fi