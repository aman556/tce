module github.com/vmware-tanzu/tce/cli/cmd/plugin/addon

go 1.16

require (
	cloud.google.com/go/storage v1.12.0 // indirect
	github.com/adrg/xdg v0.3.0 // indirect
	github.com/joshrosso/image/v5 v5.10.2-0.20210331180716-71545f2b27af
	github.com/spf13/cobra v1.1.3
	github.com/vmware-tanzu-private/core v1.3.0
	github.com/vmware-tanzu/tce/cli/pkg/common v0.0.0-00010101000000-000000000000
	github.com/vmware-tanzu/tce/cli/pkg/utils v0.0.0-00010101000000-000000000000
	honnef.co/go/tools v0.1.3 // indirect
	k8s.io/klog/v2 v2.9.0
)

replace (
	github.com/containers/storage => github.com/joshrosso/storage v1.28.2-0.20210331182201-51e6dd05f861
	github.com/go-logr/logr => github.com/go-logr/logr v0.4.0 // indirect

	// toggle this between local for development (just set these dev paths based on GOPATH)
	// github.com/vmware-tanzu-private/core => ../../vmware-tanzu-private/core
	github.com/vmware-tanzu-private/core => github.com/vmware-tanzu-private/core v1.3.1-0.20210624194100-57645921b3c0
	// github.com/vmware-tanzu-private/tanzu-cli-tkg-plugins => ../../vmware-tanzu-private/tanzu-cli-tkg-plugins
	github.com/vmware-tanzu-private/tkg-cli => github.com/vmware-tanzu-private/tkg-cli v1.3.1-0.20210624193850-4384fb896601
	// github.com/vmware-tanzu-private/tkg-cli => ../../vmware-tanzu-private/tkg-cli
	// github.com/vmware-tanzu-private/tkg-providers => ../../vmware-tanzu-private/tkg-providers
	github.com/vmware-tanzu-private/tkg-providers => github.com/vmware-tanzu-private/tkg-providers v1.3.1-0.20210422215837-027482ef8765

	// -- Local package development --
	github.com/vmware-tanzu/tce/cli/pkg/common => ../../../pkg/common
	github.com/vmware-tanzu/tce/cli/pkg/utils => ../../../pkg/utils

	k8s.io/api => k8s.io/api v0.17.11
	k8s.io/apimachinery => github.com/joshrosso/apimachinery v0.17.12-rc.0.0.20210402165939-550cad781ca6
	k8s.io/client-go => github.com/joshrosso/client-go v0.17.12-0.20210402163626-0c304a130f6a
	k8s.io/klog/v2 => k8s.io/klog/v2 v2.4.0
	k8s.io/kubectl => k8s.io/kubectl v0.17.11

	// toggle this between local for development (just set these dev paths based on GOPATH)
	sigs.k8s.io/cluster-api => github.com/vmware-tanzu/cluster-api v0.3.15-0.20210609222148-e9e6c9d422e8
	// sigs.k8s.io/cluster-api => ../../vmware-tanzu/cluster-api

	sigs.k8s.io/cluster-api-provider-azure => sigs.k8s.io/cluster-api-provider-azure v0.4.11
)