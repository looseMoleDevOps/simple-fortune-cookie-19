#!/bin/bash

# Set the URL to your application (modify as needed)
APP_URL="https://group19.sdu.eficode.academy"  # or your production/staging URL
EXPECTED_STATUS_CODE=200

# Function to test the application
test_application() {
  echo "Testing the application at $APP_URL..."

  # Use curl to test the application and capture the HTTP status code
  HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" $APP_URL)

  # Check if the expected status code is returned
  if [ "$HTTP_STATUS" -eq "$EXPECTED_STATUS_CODE" ]; then
    echo "Test passed! Application is available and returned status code $EXPECTED_STATUS_CODE."
    return 0
  else
    echo "Test failed! Application returned status code $HTTP_STATUS."
    return 1
  fi
}

# Execute the test function
test_application
