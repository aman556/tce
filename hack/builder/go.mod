module github.com/vmware-tanzu-private/hack/builder

go 1.16

// -- Used to build TCE plugins --
replace github.com/vmware-tanzu-private/core => ../../../../vmware-tanzu-private/core

require (
	github.com/spf13/cobra v1.1.3
	github.com/vmware-tanzu-private/core v1.3.0
)
