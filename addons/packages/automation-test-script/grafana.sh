#!/bin/bash

tanzu package installed list | grep "local-path-storage.community.tanzu.vmware.com"
exitcode_local_path_storage=$?
if [ "${exitcode_local_path_storage}" == 1 ] 
then
    version=$(tanzu package available list local-path-storage.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install local-path-storage --package-name local-path-storage.community.tanzu.vmware.com --version "${version}"
fi
sleep 15s

tanzu package installed list | grep "contour.community.tanzu.vmware.com"
exitcode_contour=$?
MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ "${exitcode_contour}" == 1 ] 
then
    version=$(tanzu package available list contour.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install contour --package-name contour.community.tanzu.vmware.com -f "${MY_DIR}"/contour-values.yaml --version "${version}"
fi
sleep 15s

tanzu package installed list | grep "cert-manager.community.tanzu.vmware.com"
exitcode_cert_manager=$?
if [ "${exitcode_cert_manager}" == 1 ] 
then
    version=$(tanzu package available list cert-manager.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install cert-manager --package-name cert-manager.community.tanzu.vmware.com --version "${version}"
fi
sleep 15s

tanzu package installed list | grep "grafana.community.tanzu.vmware.com"
exitcode_grafana=$?
if [ "${exitcode_grafana}" == 1 ] 
then
    version=$(tanzu package available list grafana.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install grafana --package-name grafana.community.tanzu.vmware.com --version "${version}"
fi

sleep 30s
#grafana_pod_status="$(kubectl get pod -A | grep "grafana" | awk '{print $4}')" 

while [ "$(kubectl get pod -A | grep "grafana" | awk '{print $4}')" != "Running" ]
do 
    echo "projects.registry.vmware.com/tkg/grafana/k8s-sidecar@sha256:9f1ad1e5e404bc43f9591b1189c187f535d6f61769468c49b4fc97add803d7b9 downloading"
done


grafana_pod="$(kubectl get pod -A | grep "grafana" | awk '{print $2}')" 
kubectl port-forward "${grafana_pod}" -n grafana 56016:3000 &

curl -I http://127.0.0.1:56016/api/health | grep "200"
exitcode=$?
if [ "${exitcode}" == 1 ] 
then
    echo "Grafana failed"
else
    echo "Grafana Passed"
fi
sleep 10s

tanzu package installed delete local-path-storage -y
tanzu package installed delete contour -y
tanzu package installed delete cert-manager -y
tanzu package installed delete grafana -y

