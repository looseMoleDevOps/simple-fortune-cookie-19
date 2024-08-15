#!/bin/bash

# Path to the Ingress YAML file
INGRESS_YAML="./k8s-manifests/frontend/frontend-ingress.yml"

# Extract the host value from the Ingress YAML file using yq or sed
extract_host() {
  if command -v yq >/dev/null 2>&1; then
    # If yq is installed, use it to extract the host value
    APP_URL=$(yq e '.spec.rules[0].host' "$INGRESS_YAML")
  else
    # If yq is not installed, fall back to using sed
    APP_URL=$(sed -n 's/.*host: \(.*\)/\1/p' "$INGRESS_YAML")
  fi
}

# Function to test the application
test_application() {
  echo "Testing the application at https://$APP_URL..."

  # Use curl to test the application and capture the HTTP status code
  HTTP_STATUS=$(curl -m 10 -o /dev/null -s -w "%{http_code}\n" "https://$APP_URL")

  # Check if the expected status code is returned
  if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "Test passed! Application is available and returned status code 200."
    return 0
  else
    echo "Test failed! Application returned status code $HTTP_STATUS."
    return 1
  fi
}

# Main script execution
extract_host
if [ -z "$APP_URL" ]; then
  echo "Failed to extract the application URL from $INGRESS_YAML"
  exit 1
fi

test_application
