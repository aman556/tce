module github.com/vmware-tanzu/tce

go 1.16

require (
	github.com/ghodss/yaml v1.0.0
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/protobuf v1.5.2 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/json-iterator/go v1.1.11 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e // indirect
	github.com/onsi/ginkgo v1.14.2
	github.com/onsi/gomega v1.10.3
	github.com/stretchr/testify v1.7.0 // indirect
	golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4 // indirect
	golang.org/x/sys v0.0.0-20210510120138-977fb7262007 // indirect
	golang.org/x/text v0.3.5 // indirect
	gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b // indirect
	k8s.io/api v0.20.1
	k8s.io/apimachinery v0.20.1 // indirect
	k8s.io/utils v0.0.0-20201110183641-67b214c5f920
	sigs.k8s.io/yaml v1.2.0
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
