# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/git.zsh                                            #
# - Summary: Support for git.                                                  #
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


if [[ "${commands[git]}" ]]; then

  abbrev-alias gia="git add -A"
  abbrev-alias gic="git commit -m"
  abbrev-alias gil="git pull --rebase"
  abbrev-alias giu="git push && git push --tags"

  # Do everything.
  abbrev-alias gii="git add -A && git commit --allow-empty-message && git pull --rebase && git push && git push --tags"

  abbrev-alias gis="git status -s"
  abbrev-alias gim="git commit --amend --verbose"
  abbrev-alias gim="git diff"

  abbrev-alias gip="git commit --verbose --patch"

  abbrev-alias gio="git checkout -b"

  abbrev-alias gib="git submodule update --init --recursive --remote"

  abbrev-alias gits="git stash save"
  abbrev-alias gitp="git stash pop"

  abbrev-alias gigc="git gc --aggressive --prune=all"

fi


# vim: set filetype=zsh :
