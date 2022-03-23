#!/bin/bash

kubectl -n example get --kubeconfig /tmp/kubeconfig svc node-gettingstarted-service -o jsonpath='{.status.loadBalancer.ingress[0]}'