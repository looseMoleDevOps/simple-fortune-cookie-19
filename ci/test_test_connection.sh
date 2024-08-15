#!/bin/bash
# Get host IP and port no. from k8s commands.
extract_host() {
    # Extract the line containing "8080:"
    port_number=$(kubectl --kubeconfig="$KUBECONFIG_REF" get svc | grep "8080:" | sed -E 's/.*8080:([0-9]+).*/\1/')

    # Extract one of the Node's external IP addresses
    external_ip=$(kubectl --kubeconfig="$KUBECONFIG_REF" get node -o wide | awk '{print $7}' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | shuf -n 1)

    APP_URL="$external_ip:$port_number"
}

# Function to test the application
test_application() {
  echo "Testing the application at http://$APP_URL..."

  # Use curl to test the application and capture the HTTP status code
  HTTP_STATUS=$(curl -m 10 -o /dev/null -s -w "%{http_code}\n" "http://$APP_URL")

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
# Check if environment variable KUBECONFIG_TEST is set
if [ -n "$KUBECONFIG_TEST" ]; then
    # If XX is set, use it as the kubeconfig
    echo "Using KUBECONFIG_TEST as config."
    KUBECONFIG_REF=kubeconfig
else
    # Otherwise, use the standard kubeconfig path
    echo "Using local k8s config."
    KUBECONFIG_REF="$HOME/.kube/config"
fi

extract_host
if [ -z "$APP_URL" ]; then
  echo "Failed to extract the application URL from k8s cluster info."
  exit 1
fi

test_application
