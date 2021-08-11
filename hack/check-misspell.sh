#!/usr/bin/env bash

# Copyright 2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0


set -o errexit
set -o nounset
set -o pipefail


MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export MY_DIR

# Install tools we need if it is not present
if [[ -z "$(command -v misspell)" ]]; then
curl -L https://git.io/misspell | bash
sudo install ./bin/misspell /usr/local/bin/misspell
fi

# Spell checking
misspell -error "${MY_DIR}/.."

#if [[ -z "$(misspell "${MY_DIR}/..")" ]]; 
#then
# echo ""
#else
#  echo "error"
#fi