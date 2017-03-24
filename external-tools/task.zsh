# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/task.zsh                                           #
# - Summary: Support for taskwarrior.                                          #
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


if [[ "${commands[task]}" ]]; then
  # TODO use fizzy
  if [[ "${USER}" == "alem0lars" ]]; then
    # basic
    abbrev-alias ty="task +yoroi"
    abbrev-alias tyd="task +dev"
    # by project
    abbrev-alias tydg0="tyd project:g0"
    abbrev-alias tydmop="tyd project:mop"
    abbrev-alias tydgenku="tyd project:genku"
    # most used
    abbrev-alias tydbro="tydgenku +bro"
    abbrev-alias tydhoney="tydgenku +honey"
  fi
fi


# vim: set filetype=zsh :