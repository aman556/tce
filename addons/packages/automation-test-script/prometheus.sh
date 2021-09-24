#!/bin/bash

tanzu package installed list | grep "local-path-storage.community.tanzu.vmware.com"
exitcode_local_path_storage=$?
if [ "${exitcode_local_path_storage}" == 1 ] 
then
    version=$(tanzu package available list local-path-storage.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install local-path-storage --package-name local-path-storage.community.tanzu.vmware.com --version "${version}"
fi
sleep 15s

tanzu package installed list | grep "prometheus.community.tanzu.vmware.com"
exitcode_prometheus=$?
if [ "${exitcode_prometheus}" == 1 ] 
then
    version=$(tanzu package available list prometheus.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install prometheus --package-name prometheus.community.tanzu.vmware.com --version "${version}"
fi
sleep 30s

prometheus_Pod="$(kubectl get pod -n prometheus | grep "prometheus-kube-state-metrics" | awk '{print $1}')"
echo "${prometheus_Pod}"

kubectl port-forward "${prometheus_Pod}"  -n prometheus  8080:8080 &
sleep 5s
curl localhost:8080/metrics | less | grep deployment
exitcode_metric=$?

curl localhost:8080/healthz | grep "OK"
exitcode=$?

if [ "${exitcode}" == 1 ] || [ "${exitcode_metric}" == 1 ] 
then
    echo "Prometheus failed"
else
    echo "Prometheus Passed"
fi

tanzu package installed delete local-path-storage -y
tanzu package installed delete prometheus -y
