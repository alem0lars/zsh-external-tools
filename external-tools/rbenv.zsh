# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/rbenv.zsh                                          #
# - Summary: Support for rbenv.                                                #
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


_homebrew-installed() {
  type brew &> /dev/null
}

_rbenv-from-homebrew-installed() {
  brew --prefix rbenv &> /dev/null
}

FOUND_RBENV=0
if _homebrew-installed && _rbenv-from-homebrew-installed; then
  rbenvdirs=($(brew --prefix rbenv) "${rbenvdirs[@]}")
else
  rbenvdirs=(                \
    "${HOME}/.rbenv"         \
    "/opt/rbenv"             \
    "/usr/share/rbenv"       \
    "/usr/local/rbenv"       \
    "/usr/local/opt/rbenv"   \
    "/usr/local/share/rbenv" \
  )
fi

for rbenvdir in "${rbenvdirs[@]}"; do
  if [ -d ${rbenvdir}/bin -a ${FOUND_RBENV} -eq 0 ]; then
    FOUND_RBENV=1
    if [[ ${RBENV_ROOT} = "" ]]; then
      export RBENV_ROOT=${rbenvdir}
    fi
    export PATH="${rbenvdir}/bin:${PATH}"
    eval "$(rbenv init - zsh)"
  fi
done
unset rbenvdir


# vim: set filetype=zsh :
