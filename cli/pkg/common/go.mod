module github.com/vmware-tanzu/tce/cli/pkg/common

go 1.16

require (
	github.com/ghodss/yaml v1.0.0
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/protobuf v1.4.3 // indirect
	github.com/google/go-cmp v0.5.4 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/googleapis/gnostic v0.4.1 // indirect
	github.com/imdario/mergo v0.3.11 // indirect
	github.com/mattn/go-runewidth v0.0.10 // indirect
	github.com/onsi/ginkgo v1.14.2 // indirect
	github.com/onsi/gomega v1.10.3 // indirect
	github.com/rivo/uniseg v0.2.0 // indirect
	github.com/stretchr/testify v1.7.0 // indirect
	github.com/vmware-tanzu/carvel-kapp-controller v0.19.1-0.20210422224550-3c235246c149
	github.com/vmware-tanzu/carvel-vendir v0.19.0
	github.com/vmware-tanzu/tce/cli/pkg/utils v0.0.0-00010101000000-000000000000
	go.uber.org/zap v1.15.0 // indirect
	golang.org/x/crypto v0.0.0-20201117144127-c1f2f97bffc9 // indirect
	golang.org/x/net v0.0.0-20201224014010-6772e930b67b // indirect
	golang.org/x/oauth2 v0.0.0-20201208152858-08078c50e5b5 // indirect
	golang.org/x/sys v0.0.0-20210324051608-47abb6519492 // indirect
	golang.org/x/text v0.3.4 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	k8s.io/api v0.20.1
	k8s.io/apimachinery v0.20.1
	k8s.io/client-go v0.20.1
	k8s.io/klog/v2 v2.9.0
	k8s.io/utils v0.0.0-20201110183641-67b214c5f920 // indirect
	sigs.k8s.io/controller-runtime v0.5.14
)

replace (
	github.com/containers/storage => github.com/joshrosso/storage v1.28.2-0.20210331182201-51e6dd05f861
	github.com/go-logr/logr => github.com/go-logr/logr v0.4.0 // indirect

	// toggle this between local for development (just set these dev paths based on GOPATH)
	// github.com/vmware-tanzu-private/core => ../../vmware-tanzu-private/core
	github.com/vmware-tanzu-private/core => github.com/vmware-tanzu-private/core v1.3.1-0.20210603194025-b261a8b52d56
	// github.com/vmware-tanzu-private/tanzu-cli-tkg-plugins => ../../vmware-tanzu-private/tanzu-cli-tkg-plugins
	github.com/vmware-tanzu-private/tkg-cli => github.com/vmware-tanzu-private/tkg-cli v1.3.1-0.20210603193506-9a0d210affa2
	// github.com/vmware-tanzu-private/tkg-cli => ../../vmware-tanzu-private/tkg-cli
	// github.com/vmware-tanzu-private/tkg-providers => ../../vmware-tanzu-private/tkg-providers
	github.com/vmware-tanzu-private/tkg-providers => github.com/vmware-tanzu-private/tkg-providers v1.3.1-0.20210422215837-027482ef8765

	// -- cross module development --
	github.com/vmware-tanzu/tce/cli/pkg/utils => ../utils

	k8s.io/api => k8s.io/api v0.17.11
	k8s.io/apimachinery => github.com/joshrosso/apimachinery v0.17.12-rc.0.0.20210402165939-550cad781ca6
	k8s.io/client-go => github.com/joshrosso/client-go v0.17.12-0.20210402163626-0c304a130f6a
	k8s.io/klog/v2 => k8s.io/klog/v2 v2.4.0
	k8s.io/kubectl => k8s.io/kubectl v0.17.11

	// toggle this between local for development (just set these dev paths based on GOPATH)
	sigs.k8s.io/cluster-api => github.com/vmware-tanzu/cluster-api v0.3.15-0.20210524175136-a91ea2b8f297
	// sigs.k8s.io/cluster-api => ../../vmware-tanzu/cluster-api

	sigs.k8s.io/cluster-api-provider-azure => sigs.k8s.io/cluster-api-provider-azure v0.4.11
)
