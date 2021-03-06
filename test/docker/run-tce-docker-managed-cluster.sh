#!/bin/bash

# Copyright 2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

set -e
set -x

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

"${MY_DIR}"/../install-dependencies.sh
"${MY_DIR}"/../build-tce.sh
"${MY_DIR}"/../install-jq.sh

random_id="${RANDOM}"

export MGMT_CLUSTER_NAME="management-cluster-${random_id}"
export GUEST_CLUSTER_NAME="guest-cluster-${random_id}"

tanzu management-cluster create -i docker --name ${MGMT_CLUSTER_NAME} -v 10 --plan dev --ceip-participation=false

# Check management cluster details
tanzu management-cluster get

# Get kube config of management cluster
tanzu management-cluster kubeconfig get ${MGMT_CLUSTER_NAME} --admin

"${MY_DIR}"/check-tce-cluster-creation.sh ${MGMT_CLUSTER_NAME}-admin@${MGMT_CLUSTER_NAME}

tanzu cluster create ${GUEST_CLUSTER_NAME} --plan dev

tanzu cluster list

tanzu cluster kubeconfig get ${GUEST_CLUSTER_NAME} --admin

"${MY_DIR}"/check-tce-cluster-creation.sh ${GUEST_CLUSTER_NAME}-admin@${GUEST_CLUSTER_NAME}

# TODO: Use stable version of the tce/main repo once https://github.com/vmware-tanzu/tce/issues/1250 is fixed
tanzu package repository add tce-main-latest --namespace default --url projects.registry.vmware.com/tce/main:latest

# wait for packages to be available
sleep 10

tanzu package available list

tanzu package available list fluent-bit.community.tanzu.vmware.com

fluentbit_version=$(tanzu package available list fluent-bit.community.tanzu.vmware.com -o json | jq -r '.[0].version | select(. !=null)')

tanzu package install fluent-bit --package-name fluent-bit.community.tanzu.vmware.com --version "${fluentbit_version}"

tanzu package installed list

kubectl -n fluent-bit get all

kubectl get installedpackage,apps --all-namespaces

tanzu cluster delete ${GUEST_CLUSTER_NAME} --yes

num_of_clusters=$(tanzu cluster list -o json | jq 'length')

while [ "$num_of_clusters" != "0" ]
do
    echo "Waiting for workload cluster to get deleted..."
    sleep 2;
    num_of_clusters=$(tanzu cluster list -o json | jq 'length')
done

echo "Workload cluster ${GUEST_CLUSTER_NAME} successfully deleted"

tanzu management-cluster delete ${MGMT_CLUSTER_NAME} --yes

echo "Management cluster ${GUEST_CLUSTER_NAME} successfully deleted"
