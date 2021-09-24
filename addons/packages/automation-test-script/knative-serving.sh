#!/bin/bash

tanzu package installed list | grep "contour.community.tanzu.vmware.com"
exitcode_contour=$?
MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ "${exitcode_contour}" == 1 ] 
then
    version=$(tanzu package available list contour.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install contour --package-name contour.community.tanzu.vmware.com -f "${MY_DIR}"/contour-values.yaml --version "${version}"
fi
sleep 30s


tanzu package installed list | grep "knative-serving.community.tanzu.vmware.com"
exitcode=$?
if [ "${exitcode}" == 1 ] 
then
    version=$(tanzu package available list knative-serving.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
    tanzu package install knative-serving --package-name knative-serving.community.tanzu.vmware.com --version "${version}"
fi
sleep 30s


kubectl apply --filename "${MY_DIR}"/helloworld-service.yaml
sleep 30s

#URL="$(kubectl get ksvc --namespace example | tail -n 1 | awk '{print $2}')"
#curl "${URL}" | grep "hello!"

#exitcode=$?

#sleep 300s

#kubectl get pods --namespace example | grep "No resources found in example namespace."
#exitcode_pod=$? 

#if [ "${exitcode}" == 1 ] || [ "${exitcode_pod}" == 1 ]
#then
#    echo "knative-Serving failed"
#else
#    echo "knative-Serving Passed"
#fi

#tanzu package installed delete knative-serving -y
#tanzu package installed delete contour -y
