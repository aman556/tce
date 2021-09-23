#!/bin/bash

tanzu package installed list | grep "fluent-bit.community.tanzu.vmware.com"

exitcode=$?

if [ "${exitcode}" == 1 ] 
then
    version=$(tanzu package available list fluent-bit.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install fluent-bit --package-name fluent-bit.community.tanzu.vmware.com --version "${version}"
    pod_name="$(kubectl get pods -n fluent-bit | tail -n 1 | awk '{print $1}')"
    kubectl logs "${pod_name}" -n fluent-bit | grep "Fluent Bit v1.7.5"
fi

sleep 30s

exitcode=$?
tanzu package installed delete fluent-bit -y

if [ "${exitcode}" == 1 ] 
then
    echo "Fluent-bit failed"
else
    echo "Fluent-bit Passed"
fi
