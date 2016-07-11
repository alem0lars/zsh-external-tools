# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/sman.zsh                                           #
# - Summary: Support for sman.                                                 #
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

# If sman is in a well-known path, add it to `$PATH`.
if [ ! $commmands[sman] ]; then
  if [ -d ~/.sman/bin ]; then
    export PATH="$PATH:~/.sman/bin"
  fi
fi

if [ $commmands[sman] ]; then
  
  snip() {
    if [[ ${1} == "run" ]] || [[ ${1} == "r" ]]; then
      eval "$(sman $@)"
    else
      sman $@
    fi
  }
  
  _escaped_string() {
    if [[ "$1" =~ ^[-:_[:alnum:]]*$ ]];
    then
      echo "$1"
    elif [[ "$1" =~ ^[^\']*$ ]];
    then
      echo "'$1'"
    else
      echo "\"$1\""
    fi
  }
  
  _history_command() {
    if [[ ! -z $BASH_VERSION ]];
    then
      echo "history -s"
    elif [[ ! -z $ZSH_VERSION ]];
    then
      echo "print -s"
    fi
  }
  
  _append_history() {
    local command
    for arg; do
      local output=$(_escaped_string "$arg")
      if [[ ! -z $command ]];
      then
        command="$command $output"
      else
        command="$output"
      fi
    done
    $(_history_command) "$command"
  }

fi


# vim: set filetype=zsh :
