# ─────────────────────────────────────────────────────────────────────────────┐
#                                                                              │
# Name:    external-tools/exa.zsh                                              │
# Summary: Integration with tool `exa`.                                        │
#                                                                              │
# Authors:                                                                     │
#   - Alessandro Molari <molari.alessandro@gmail.com> (alem0lars)              │
#                                                                              │
# Project:                                                                     │
#   - Homepage:        https://github.com/alem0lars/zsh-external-tools         │
#   - Getting started: see README.md in the project root folder                │
#                                                                              │
# License: Apache v2.0 (see below)                                             │
#                                                                              │
# ─────────────────────────────────────────────────────────────────────────────┤
#                                                                              │
# Licensed to the Apache Software Foundation (ASF) under one more contributor  │
# license agreements.  See the NOTICE file distributed with this work for      │
# additional information regarding copyright ownership. The ASF licenses this  │
# file to you under the Apache License, Version 2.0 (the "License"); you may   │
# not use this file except in compliance with the License.                     │
# You may obtain a copy of the License at                                      │
#                                                                              │
#   http://www.apache.org/licenses/LICENSE-2.0                                 │
#                                                                              │
# Unless required by applicable law or agreed to in writing, software          │
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT    │
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.             │
# See the License for the specific language governing permissions and          │
# limitations under the License.                                               │
#                                                                              │
# ─────────────────────────────────────────────────────────────────────────────┘


if [ $commands[exa] ]; then

  alias l="exa -bgh --git --classify"
  alias ll="ll1"
  alias lr="l -R"
  alias la="l -a"
  alias lla="ll -a"

  alias l1="l -L 1"
  alias l2="l -L 2"
  alias l3="l -L 3"
  alias l4="l -L 4"
  alias lx="l -L"

  alias ll1="l -l -T -L 1"
  alias ll2="l -l -T -L 2"
  alias ll3="l -l -T -L 3"
  alias ll4="l -l -T -L 4"
  alias llx="l -l -T -L"

else # Fallback using ls

  if [[ $OSTYPE == darwin* && $commands[gls] ]]; then
    alias l="gls --color=auto"
  elif [[ $OSTYPE == linux* ]]; then
    alias l="ls --color=auto"
  fi

  alias ll="l -lshF"
  alias lr="l -lshFR"
  alias la="ll -a"

fi


# vim: set filetype=zsh :
