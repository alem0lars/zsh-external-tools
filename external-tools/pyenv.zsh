# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/pyenv.zsh                                          #
# - Summary: Support for pyenv.                                                #
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

_pyenv-from-homebrew-installed() {
  brew --prefix pyenv &> /dev/null
}

FOUND_PYENV=0
if _homebrew-installed && _pyenv-from-homebrew-installed; then
  pyenvdirs=($(brew --prefix pyenv) "${pyenvdirs[@]}")
else
  pyenvdirs=(                \
    "${HOME}/.pyenv"         \
    "/opt/pyenv"             \
    "/usr/share/pyenv"       \
    "/usr/local/pyenv"       \
    "/usr/local/opt/pyenv"   \
    "/usr/local/share/pyenv" \
  )
fi

for pyenvdir in "${pyenvdirs[@]}"; do
  if [ -d ${pyenvdir} -a ${FOUND_PYENV} -eq 0 ]; then
    FOUND_PYENV=1
    if [[ ${PYENV_ROOT} = "" ]]; then
      export PYENV_ROOT="${pyenvdir}"
    fi
    export PATH="${pyenvdir}/bin:${PATH}"
    eval "$(pyenv init - zsh --no-rehash)"
  fi
done
unset pyenvdir


# vim: set filetype=zsh :
