#!/bin/bash

# Copyright 2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

tanzu package installed list | grep "local-path-storage.community.tanzu.vmware.com"

exitcode=$?

if [ "${exitcode}" == 1 ] 
then
  version=$(tanzu package available list local-path-storage.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
  tanzu package install local-path-storage --package-name local-path-storage.community.tanzu.vmware.com --version "${version}"
fi

sleep 15s
MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
kubectl create -f "${MY_DIR}"/pvc.yaml
kubectl create -f "${MY_DIR}"/pod.yaml

sleep 30

PVC_status="$(kubectl get pvc | grep "local-path-pvc" | awk '{print $2}')"

Pod_status="$(kubectl get pod | grep "volume-test" | awk '{print $3}')"

if [ "${PVC_status}" != "Bound" ]
then
    echo "PVC did not bound to PV. check the storage class name"
fi

if [ "${Pod_status}" != "Running" ]
then
    echo "Pod for PV is not in Running state"
fi

kubectl exec volume-test -- sh -c "echo local-path-storage-test > /data/test"

sleep 15
kubectl delete -f "${MY_DIR}"/pod.yaml
 
sleep 15s

kubectl create -f "${MY_DIR}"/pod.yaml

sleep 15s

Output="$(kubectl exec volume-test cat /data/test)"

if [ "${Output}" != "local-path-storage-test" ]
then
    echo "local-path-storage test failed"
else
    echo "local-path-storage test Passed"
fi

kubectl delete pod/volume-test
sleep 15s
kubectl delete persistentvolumeclaim/local-path-pvc
tanzu package installed delete local-path-storage -y