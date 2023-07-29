#!/bin/bash

### Create Cluster

echo 'apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30000
    hostPort: 30000
    listenAddress: "0.0.0.0" # Optional, defaults to "0.0.0.0"
    protocol: tcp # Optional, defaults to tcp' > /var/lib/jenkins/kind.yaml

kind create cluster --config=/var/lib/jenkins/kind.yaml