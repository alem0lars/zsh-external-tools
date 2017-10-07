#!/usr/bin/env zsh
#
# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    zsh-external-tools.zsh                                            #
# - Summary: Entry-point which loads the enabled external tools support.       #
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


# Return if requirements are not found.
if [[ "${TERM}" == 'dumb' ]]; then
  return 1
fi

# Built-in readlink in OSX doesn't work: the coreutils version is needed.
if [[ `uname` == 'Darwin' ]]; then
  readlink_cmd=greadlink
else
  readlink_cmd=readlink
fi

base_dir=$(dirname $(eval $readlink_cmd -f ${(%):-%N}))
# Load external tools support.
# Accept var-args of names for external tools which support should be loaded.
function load_external_tools {
  local -a external_tools
  external_tools=("$argv[@]")
  external_tools_dir="${base_dir}/external-tools"
  for f (${external_tools_dir}/*.zsh) {
    name="${$(basename ${f})%.*}"
    if [[ "${external_tools[(r)$name]}" == "${name}" ]] || \
       [[ $#external_tools -eq 0 ]]; then
      source "${f}"
    fi
  }
}

# Load the enabled external tools.
zstyle -a ':external-tools' enabled 'external_tools_enabled'
load_external_tools "$external_tools_enabled[@]"

# Cleanup
unset external_tools_enabled
unset base_dir


# vim: set filetype=zsh :
