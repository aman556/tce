module github.com/vmware-tanzu/tce

go 1.16

replace (
    // -- Used to build TCE plugins --
	github.com/vmware-tanzu-private/core => ../../vmware-tanzu-private/core

	// -- Local plugins --
	github.com/vmware-tanzu/tce/cli/cmd/plugin/addon => ./cli/cmd/plugin/addon
	github.com/vmware-tanzu/tce/cli/cmd/plugin/standalone-cluster => ./cli/cmd/plugin/standalone-cluster

    // -- Local shared modules --
	github.com/vmware-tanzu/tce/cli/pkg/common => ./cli/pkg/common
	github.com/vmware-tanzu/tce/cli/pkg/utils => ./cli/pkg/utils
)

require (
	github.com/AlecAivazis/survey/v2 v2.1.1 // indirect
	github.com/ghodss/yaml v1.0.0
	github.com/google/go-github v17.0.0+incompatible
	github.com/onsi/ginkgo v1.14.2
	github.com/onsi/gomega v1.10.4
	github.com/vmware-tanzu-private/core v1.3.0
	github.com/vmware-tanzu/tce/cli/cmd/plugin/addon v0.0.0
	github.com/vmware-tanzu/tce/cli/cmd/plugin/standalone-cluster v0.0.0
	github.com/vmware-tanzu/tce/cli/pkg/common v0.0.0
	github.com/vmware-tanzu/tce/cli/pkg/utils v0.0.0
	golang.org/x/oauth2 v0.0.0-20201208152858-08078c50e5b5
	k8s.io/api v0.20.1
	k8s.io/utils v0.0.0-20201110183641-67b214c5f920
	sigs.k8s.io/yaml v1.2.0
)
