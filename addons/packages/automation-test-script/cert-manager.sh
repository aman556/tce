#!/bin/bash

tanzu package installed list | grep "cert-manager.community.tanzu.vmware.com"

exitcode=$?

if [ "${exitcode}" == 1 ] 
then
version=$(tanzu package available list cert-manager.community.tanzu.vmware.com | tail -n 1 | awk '{print $2}')
tanzu package install cert-manager --package-name cert-manager.community.tanzu.vmware.com --version "${version}"
sleep 30s
fi



cat <<EOF | kubectl apply --filename -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: self-signed
spec:
  selfSigned: {}
EOF

cat <<EOF | kubectl apply --filename -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: private-ca
spec:
  ca:
    secretName: private-ca
EOF

cat <<EOF | kubectl apply --filename -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: private-ca
spec:
  isCA: true
  duration: 2160h
  secretName: private-ca
  commonName: private-ca
  subject:
    organizations:
      - cert-manager
  issuerRef:
    name: self-signed
    kind: Issuer
    group: cert-manager.io
EOF

cat <<EOF | kubectl apply --filename -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: example-com
  namespace: default
spec:
  secretName: example-com-tls
  issuerRef:
    name: private-ca
    kind: Issuer
  commonName: example.com
  dnsNames:
    - example.com
    - www.example.com
EOF

sleep 30s

status="$(kubectl get certificate/example-com | tail -n 1 | awk '{print $2}')"

tanzu package installed delete cert-manager -y

if [ "${status}" != "True" ]
then 
    echo "cert-manager failed"
else
    echo "cert-manager Passed"
fi


