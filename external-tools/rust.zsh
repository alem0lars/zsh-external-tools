# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/rust.zsh                                           #
# - Summary: Support for rust.                                                 #
# - Authors:                                                                   #
#   - Alessandro Molari <molari.alessandro@gmail.com> (alem0lars)              #
#                                                                              #
# Project informations:                                                        #
#   - Homepage:        https://github.com/alem0lars/zsh-external-tools         #
#   - Getting started: see README.md in the project root folder                #
#                                                                              #
# License: Apache v2.0 (see below)                                             #
#                                                                              #
################################################################################
#                                                                              #
# Licensed to the Apache Software Foundation (ASF) under one more contributor  #
# license agreements.  See the NOTICE file distributed with this work for      #
# additional information regarding copyright ownership. The ASF licenses this  #
# file to you under the Apache License, Version 2.0 (the "License"); you may   #
# not use this file except in compliance with the License.                     #
# You may obtain a copy of the License at                                      #
#                                                                              #
#   http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                              #
# Unless required by applicable law or agreed to in writing, software          #
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT    #
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.             #
# See the License for the specific language governing permissions and          #
# limitations under the License.                                               #
#                                                                              #
# }}} ##########################################################################


if [[ $commands[rustup] ]]; then
  # Setup completion.
  local _rust_zsh_fn="$(rustc --print sysroot)/share/zsh/site-functions"
  if [ -d "${_rust_zsh_fn}" ]; then
    if [ -f "${_rust_zsh_fn}" ]; then
      rm "${_rust_zsh_fn}/_rust"
    fi
    rustup completions zsh > "${_rust_zsh_fn}/_rust"
  fi
  fpath+=("${_rust_zsh_fn}")
  unset _rust_zsh_fn

  # Cargo support.
  if [ -d "${HOME}/.cargo/bin" ]; then
    export PATH="${PATH}:${HOME}/.cargo/bin"
  fi

  # Racer support.
  if [ -d "$(rustc --print sysroot)/lib/rustlib/src" ]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src"
  fi
fi


# vim: set filetype=zsh :
