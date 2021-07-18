// Copyright 2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package e2e_test

import (
	"fmt"
	"os/exec"
	"strings"
	"time"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("Fluent-bit Addon E2E Test", func() {
	Specify("check fluent-bit is running", func() {
		var result string
		signal := make(chan *exec.Cmd)
		timeOut := make(chan bool)
		go func() {
			r, err := cmdHelperUp.CliRunnerChan("kubectl", nil, signal, cmdHelperUp.CommandArgs["k8s-port-forward"]...)
			println(r)
			Expect(err).To(HaveOccurred())
		}()
		command := <-signal
		println("------------------------->>>>>>>>>>>>>>>>>>>>", command)
		time.AfterFunc(ApiCallTimeout, func() {
			timeOut <- true
		})
		//defer tr.Stop()

		for {
			select {
			case <-timeOut:
				if command != nil {
					command.Process.Kill()
				}
				close(signal)
				println("command timed out")
				Expect(result).Should(ContainSubstring("HTTP/1.1 200 OK"))

			default:
				// ping fluent-bit health api call. If it retunrs successful that means,yes it is working.
				result, _ = cmdHelperUp.Run("curl", nil, "fluent-bit-health-check")

				if strings.Contains(result, "HTTP/1.1 200 OK") {
					fmt.Println("Test successfully done")
					if command != nil {
						command.Process.Kill()
					}
					Expect(result).Should(ContainSubstring("HTTP/1.1 200 OK"))
				}
			}
			if result != "" {
				close(timeOut)
				close(signal)
				if command != nil {
					command.Process.Kill()
				}
				break
			}
		}
	})
})
