# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/docker.zsh                                         #
# - Summary: Support for docker.                                               #
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


if [ $commands[docker] ]; then # check if 'docker' is installed
  
  VM=default
  DOCKER_MACHINE=$commands[docker-machine]
  VBOXMANAGE=$commands[VBoxManage]
  
  # Create the docker host if it doesn't exit.
  $VBOXMANAGE showvminfo $VM &> /dev/null
  VM_EXISTS_CODE=$?
  if [ $VM_EXISTS_CODE -eq 1 ]; then
    $DOCKER_MACHINE rm -f $VM &> /dev/null
    rm -rf ~/.docker/machine/machines/$VM
    $DOCKER_MACHINE create -d virtualbox --virtualbox-memory 2048 --virtualbox-disk-size 204800 $VM
  fi

  # Start the docker host.
  VM_STATUS=$($DOCKER_MACHINE status $VM)
  if [ "$VM_STATUS" != "Running" ]; then
    $DOCKER_MACHINE start $VM
    yes | $DOCKER_MACHINE regenerate-certs $VM
  fi

  # Setup docker environment.
  eval $($DOCKER_MACHINE env $VM --shell=zsh)
fi
