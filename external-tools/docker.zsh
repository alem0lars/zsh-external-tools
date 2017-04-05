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


if [[ "${commands[docker]}" ]]; then

  # Docker info.
  abbrev-alias doci='docker info'

  # List all containers.
  abbrev-alias doclsc='docker ps -a -q'
  # List all non-running containers.
  abbrev-alias doclscnr='docker ps -a -f status=exited -f status=created -q'

  # List all images.
  abbrev-alias doclsi='docker images -a -q'
  # List all dangling docker images.
  abbrev-alias doclsid='docker images -f dangling=true -q'

  # List all dangling volumes.
  abbrev-alias doclsvd='docker volume ls -qf dangling=true'

  # Remove all containers.
  abbrev-alias docrmc='docker rm $(docker ps -a -q)'
  # Remove all non-running containers.
  abbrev-alias docrmcnr='docker rm $(docker ps -a -f status=exited -f status=created -q)'

  # Remove all images.
  abbrev-alias docrmi='docker rmi $(docker images -a -q)'
  # Remove all dangling docker images.
  abbrev-alias docrmid='docker rmi $(docker images -f dangling=true -q)'

  # Remove all dangling volumes.
  abbrev-alias docrmvd='docker volume rm $(docker volume ls -qf dangling=true)'

fi


# vim: set filetype=zsh :
