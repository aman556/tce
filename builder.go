// +build tools

// Copyright 2021 VMware, Inc. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

// Package tools imports things required by build scripts, to force `go mod` to see them as dependencies
package tools

import (
	_ "github.com/vmware-tanzu-private/core"

	// Local plugins
	_ "github.com/vmware-tanzu/tce/cli/cmd/plugin/addon"
	_ "github.com/vmware-tanzu/tce/cli/cmd/plugin/standalone-cluster"

	_ "github.com/vmware-tanzu/tce/cli/pkg/common"
	_ "github.com/vmware-tanzu/tce/cli/pkg/utils"
)
