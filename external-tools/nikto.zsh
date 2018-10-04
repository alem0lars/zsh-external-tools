# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/nikto.zsh                                          #
# - Summary: Support for nikto.                                                #
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


if [[ "${commands[nikto]}" ]]; then

  # $1 = target url
  function nikto-scan() {
    nikto -Cgidirs=all -Format=htm -output=. -Save=. -host $1
  }

  # $1 = target url
  function nikto-scan-full() {
    nikto -Plugins=@@ALL -Cgidirs=all -Format=htm -output=. -Save=. -host $1
  }

fi


# vim: set filetype=zsh :
