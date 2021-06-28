// +build tools

// Copyright 2021 VMware, Inc. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

// Package tools imports things required by build scripts, to force `go mod` to see them as dependencies
package builder

import (
	_ "github.com/spf13/cobra"
	_ "github.com/vmware-tanzu-private/core"
	_ "github.com/vmware-tanzu-private/core/pkg/v1/cli"
	_ "github.com/vmware-tanzu-private/core/pkg/v1/cli/component"
	_ "github.com/vmware-tanzu-private/core/pkg/v1/cli/command/core"
	_ "github.com/vmware-tanzu-private/core/pkg/v1/builder/command"
)
