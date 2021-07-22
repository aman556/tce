// Copyright 2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package e2e_test

import (
	"fmt"
	"os"
	"testing"
	"time"

	"github.com/vmware-tanzu/tce/addons/packages/knative-serving/test/e2e"
	"github.com/vmware-tanzu/tce/test/pkg/cmdhelper"

	. "github.com/onsi/ginkgo"

	. "github.com/onsi/gomega"
)

func TestFluentBitE2E(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "knative-serving addon package e2e test suite")
}

var (
	cmdHelperUp             *cmdhelper.CmdHelper
	cmdHelperDown           *cmdhelper.CmdHelper
	DeploymentTimeout       = 120 * time.Second
	DeploymentCheckInterval = 5 * time.Second
	ApiCallTimeout          = 20 * time.Second
)

var _ = BeforeSuite(func() {
	var err error
	cmdHelperUp, err = cmdhelper.New(e2e.GetAllUpCmds(), os.Stdin)
	Expect(err).NotTo(HaveOccurred())

	cmdHelperDown, err = cmdhelper.New(e2e.GetTearDownCmds(), os.Stdin)
	Expect(err).NotTo(HaveOccurred())

	// delete knative-serving if at all already installed
	// nothing to worry about the err or result here
	cmdHelperDown.CliRunner("tanzu", nil, cmdHelperDown.GetFormatted("tanzu-package-delete", "$", []string{"knative-serving.tce.vmware.com"})...)

	result, err := cmdHelperUp.CliRunner("tanzu", nil, cmdHelperUp.GetFormatted("tanzu-package-install", "$", []string{"knative-serving.tce.vmware.com"})...)
	Expect(err).NotTo(HaveOccurred())
	Expect(result).Should(ContainSubstring("Installed package in default/knative-serving.tce.vmware.com"))

	// to ensure knative activator pod is ready
	EventuallyWithOffset(1, func() (string, error) {
		return cmdHelperUp.CliRunner("kubectl", nil, cmdHelperUp.GetFormatted("k8s-check-pod-ready-status", "$", []string{"app=activator", "knative-serving"})...)
	}, DeploymentTimeout, DeploymentCheckInterval).Should(ContainSubstring("Running"), fmt.Sprintln("pod was not ready"))

	/*// to ensure knative-serving deamonset
	EventuallyWithOffset(1, func() (string, error) {
		return cmdHelperUp.CliRunner("kubectl", nil, cmdHelperUp.GetFormatted("k8s-daemonset-state", "$", []string{"knative-serving", `jsonpath={..status.desiredNumberScheduled}`})...)
	}, DeploymentTimeout, DeploymentCheckInterval).Should(Equal("2"), fmt.Sprintln("daemonset was not ready"))
	EventuallyWithOffset(1, func() (string, error) {
		return cmdHelperUp.CliRunner("kubectl", nil, cmdHelperUp.GetFormatted("k8s-daemonset-state", "$", []string{"knative-serving", `jsonpath={..status.numberAvailable}`})...)
	}, DeploymentTimeout, DeploymentCheckInterval).Should(Equal("2"), fmt.Sprintln("daemonset was not ready"))*/
})
var _ = AfterSuite(func() {
	// delete the knative-serving package
	result, err := cmdHelperDown.CliRunner("tanzu", nil, cmdHelperDown.GetFormatted("tanzu-package-delete", "$", []string{"knative-serving.tce.vmware.com"})...)
	Expect(err).NotTo(HaveOccurred())
	Expect(result).Should(ContainSubstring("Deleted default/knative-serving.tce.vmware.com"))
})
