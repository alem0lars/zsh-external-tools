# ─────────────────────────────────────────────────────────────────────────────┐
#                                                                              │
# Name:    external-tools/openssl.zsh                                          │
# Summary: Integration with tool `openssl`.                                    │
#                                                                              │
# Authors:                                                                     │
#   - Alessandro Molari <molari.alessandro@gmail.com> (alem0lars)              │
#                                                                              │
# Project:                                                                     │
#   - Homepage:        https://github.com/alem0lars/zsh-external-tools         │
#   - Getting started: see README.md in the project root folder                │
#                                                                              │
# License: Apache v2.0 (see below)                                             │
#                                                                              │
# ─────────────────────────────────────────────────────────────────────────────┤
#                                                                              │
# Licensed to the Apache Software Foundation (ASF) under one more contributor  │
# license agreements.  See the NOTICE file distributed with this work for      │
# additional information regarding copyright ownership. The ASF licenses this  │
# file to you under the Apache License, Version 2.0 (the "License"); you may   │
# not use this file except in compliance with the License.                     │
# You may obtain a copy of the License at                                      │
#                                                                              │
#   http://www.apache.org/licenses/LICENSE-2.0                                 │
#                                                                              │
# Unless required by applicable law or agreed to in writing, software          │
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT    │
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.             │
# See the License for the specific language governing permissions and          │
# limitations under the License.                                               │
#                                                                              │
# ─────────────────────────────────────────────────────────────────────────────┘


if [ $commands[openssl] ]; then

  # Create passwordless RSA key
  abbrev-alias ossl-create-key="openssl genrsa -out mykey.key 2048"

  # Create password-protected RSA key
  abbrev-alias ossl-create-key-pwd="openssl genrsa -des3 -out mykey.key 2048"

  # Create certificate signing request
  abbrev-alias ossl-create-sign-req="openssl req -new -key device.key -out device.csr"

  # Self-sign certificate
  abbrev-alias ossl-selfsign-crt="openssl req -x509 -new -nodes -key mykey.key -sha256 -days 1024 -out mykey.pem"

  # Sign certificate
  abbrev-alias ossl-sign-crt="openssl x509 -req -in mycert.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out mycert.crt -days 500 -sha256"

  # $1 = name
  # $2 = certificate authority file name
  # $3 = days of validity
  function build-client() {
    openssl genrsa -des3 -out "$1.key" 2048
    openssl req -new -key "$1.key" -out "$1.csr"
    openssl x509 -req -in "$1.csr" -CA "$2.pem" -CAkey "$2.key" \
        -CAcreateserial -out "$1.crt" -days $3 -sha256
  }

fi


# vim: set filetype=zsh :
