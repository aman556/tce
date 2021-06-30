module github.com/vmware-tanzu-private/hack/builder

go 1.16

// -- Used to build TCE plugins with local codebase --
// replace github.com/vmware-tanzu-private/core => ../../../../vmware-tanzu-private/core

require (
	github.com/spf13/cobra v1.1.3
	github.com/vmware-tanzu-private/core v1.4.0-pre-alpha-1.0.20210630191919-68e138d2a4db
)
