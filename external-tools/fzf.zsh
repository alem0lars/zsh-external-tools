# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/fzf.zsh                                            #
# - Summary: Support for fzf.                                                  #
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


if [ $commands[fzf] ]; then
  _base_dir=$(dirname $(dirname $(readlink -f $commands[fzf])))
elif [ -d ${HOME}/.fzf ]; then
  _base_dir="${HOME}/.fzf"
fi

if [ -d "${_base_dir}" ]; then
  _bin_dir="${_base_dir}/bin"
  _man_dir="${_base_dir}/man"
  _shell_dir="${_base_dir}/shell"

  # Setup `$PATH`.
  if [[ ! "$PATH" == *${_bin_dir}* ]]; then
    export PATH="$PATH:${_bin_dir}"
  fi

  # Setup `$MANPATH`.
  if [[ ! "$MANPATH" == *${_man_dir}* && -d "${_man_dir}" ]]; then
    export MANPATH="$MANPATH:${_man_dir}"
  fi
  
  # Enable auto-completion.
  [[ $- == *i* ]] && source "${_shell_dir}/completion.zsh" 2> /dev/null
  
  # Setup key-bindings.
  source "${_shell_dir}/key-bindings.zsh"
  
  unset _base_dir
  unset _bin_dir
  unset _man_dir
  unset _shell_dir
fi


# vim: set filetype=zsh :