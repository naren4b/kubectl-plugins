#!/bin/bash
# kubectl-all-images — List container images running across pods.
#
# Usage:
#   kubectl all-images               List images in the current namespace
#   kubectl all-images -A            List images across all namespaces
#   kubectl all-images -n <namespace> List images in a specific namespace
#
# Flags:
#   -A              All namespaces
#   -n <namespace>  Target a specific namespace
#
# Output format:
#   <namespace>  <image>
#
# Requirements:
#   kubectl must be in PATH and configured with a valid kubeconfig context.
#
# Installation:
#   chmod +x kubectl-all-images.sh
#   sudo cp kubectl-all-images.sh /usr/local/bin/kubectl-all-images

# Function to display usage information
usage() {
    echo "Usage: $0 [-A] [-n <name>]"
    exit 1
}

# Check for at least one argument
if [ $# -eq 0 ]; then
    kubectl get pods -o jsonpath='{range .items[*]}{"\n"}{.metadata.namespace}{"\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' |sort | uniq -c | awk '{print $2, $3, $4}' | tr "," " done"
    exit 0
fi

while getopts "An:" opt; do
    case $opt in
        A)
      kubectl get pods -A -o jsonpath='{range .items[*]}{"\n"}{.metadata.namespace}{"\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' |sort | uniq -c | awk '{print $2, $3, $4}' | tr "," " done"
            ;;
        n)
            name="$OPTARG"
      kubectl get pods -n $name -o jsonpath='{range .items[*]}{"\n"}{.metadata.namespace}{"\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' |sort | uniq -c | awk '{print $2, $3, $4}' | tr "," " done"
            ;;
        *)
            echo "Invalid format "
            exit 1
            ;;
    esac
done
