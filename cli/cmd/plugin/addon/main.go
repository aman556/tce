// Copyright 2020-2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package main

import (
	"os"

	"k8s.io/klog/v2"

	"github.com/vmware-tanzu-private/core/pkg/v1/cli"
	"github.com/vmware-tanzu-private/core/pkg/v1/cli/command/plugin"

	. "github.com/vmware-tanzu/tce/cli/cmd/plugin/addon/pkg"
)

var descriptor = cli.PluginDescriptor{
	Name:        "package",
	Description: "Package management",
	Version:     cli.BuildVersion,
	BuildSHA:    "",
	Group:       cli.ManageCmdGroup,
}

func main() {
	// plugin!
	p, err := plugin.NewPlugin(&descriptor)
	if err != nil {
		klog.Fatalf("%v", err)
	}

	p.AddCommands(
		ListCmd,
		ConfigureCmd,
		InstallCmd,
		DeleteCmd,
		RepositoryCmd,
	)
	if err := p.Execute(); err != nil {
		os.Exit(1)
	}
}
