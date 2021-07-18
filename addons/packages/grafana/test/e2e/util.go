// Copyright 2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package e2e

// GetAllUpCmds returns all commands used to run on tanzu or k8s
// these commands are w.r.t gatekeeper addon e2e only
func GetAllUpCmds() map[string][]string {
	return map[string][]string{
		"k8s-apply":                   []string{"apply", "-f", "$"},
		"k8s-get-crds":                []string{"get", "crds"},
		"k8s-create-ns":               []string{"create", "ns", "$"},
		"k8s-port-forward":            []string{"port-forward", `deployment.apps/grafana`, "-n", "grafana-addon", `56016:3000`},
		"k8s-deployment-ready-status": []string{"get", "deployment", "-l", "$", "-n", "$", "-o", `jsonpath={..status.conditions[?(@.type=="Available")].status}`},
		"tanzu-package-install":       []string{"package", "install", "$"},

		"grafana-health-check": []string{"-I", "http://127.0.0.1:56016/api/health"},
	}
}

// GetTearDownCmds returns all commands used to tear-down.
// contains tanzu or k8s commands
// these commands are w.r.t gatekeeper addon e2e only
func GetTearDownCmds() map[string][]string {
	return map[string][]string{
		"k8s-delete":    []string{"delete", "-f", "$"},
		"k8s-delete-ns": []string{"delete", "ns", "$"},

		"tanzu-package-delete": []string{"package", "delete", "$"},
	}
}