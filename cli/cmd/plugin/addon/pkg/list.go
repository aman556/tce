// Copyright 2020-2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package pkg

import (
	"github.com/spf13/cobra"

	"github.com/vmware-tanzu/tce/cli/pkg/utils"
)

// ListCmd represents the list command
var ListCmd = &cobra.Command{
	Use:   "list",
	Short: "List packages available in the cluster",
	PreRunE: func(cmd *cobra.Command, args []string) (err error) {
		mgr, err = NewManager()
		return err
	},
	RunE: list,
}

func init() {
	ListCmd.Flags().StringVarP(&outputFormat, "output", "o", "", "Print metadata in format (yaml|json)")
}

func list(cmd *cobra.Command, args []string) error {
	pkgs, err := mgr.kapp.RetrievePackages()
	if err != nil {
		return utils.NonUsageError(cmd, err, "unable to retrieve package information.")
	}

	// list all packages known in the cluster
	writer := utils.NewTableWriter(cmd.OutOrStdout(), "NAME", "VERSION", "DESCRIPTION")
	for _, pkg := range pkgs {
		writer.AddRow(pkg.Spec.PublicName, pkg.Spec.Version, pkg.Spec.Description)
	}
	writer.Render()

	return nil
}