# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/fzf.zsh                                            #
# - Summary: Support for fzf.                                                  #
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

function fzf-preview-widget() {
  local opts="${FZF_DEFAULT_OPTS} --preview-window right:70% --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {}) 2> /dev/null | head -500'"
  local height="98%"

  LBUFFER="${LBUFFER}$(FZF_DEFAULT_OPTS="${opts}" FZF_TMUX_HEIGHT="${height}" __fsel)"

  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}

################################################################################

if [[ -d "${HOME}/.fzf" ]]; then
  _base_dir="${HOME}/.fzf"
fi

if [[ -d "${_base_dir}" ]]; then
  # Setup `$PATH`.
  _bin_dir="${_base_dir}/bin"
  if [[ -d "${_bin_dir}" ]]; then
    if [[ ! "$PATH" == *${_bin_dir}* ]]; then
      export PATH="$PATH:${_bin_dir}"
    fi
  fi
  unset _bin_dir

  # Setup `$MANPATH`.
  _man_dir="${_base_dir}/man"
  if [[ -d "${_man_dir}" && ! "$MANPATH" == *${_man_dir}* ]]; then
    export MANPATH="$MANPATH:${_man_dir}"
  fi
  unset _man_dir

  _shell_dir="${_base_dir}/shell"
  if [[ -d "${_shell_dir}" ]]; then
    # Enable auto-completion.
    [[ $- == *i* ]] && source "${_shell_dir}/completion.zsh" 2> /dev/null
    # Setup key-bindings.
    source "${_shell_dir}/key-bindings.zsh"
  fi
  unset _shell_dir
  unset _base_dir
elif [[ -d "/usr/share/doc/fzf" ]]; then
  # Enable auto-completion.
  if [[ -f "/usr/share/doc/fzf/completion.zsh" ]]; then
    source "/usr/share/doc/fzf/completion.zsh"
  fi
  # Setup key-bindings.
  if [[ -f "/usr/share/doc/fzf/key-bindings.zsh" ]]; then
    source "/usr/share/doc/fzf/key-bindings.zsh"
  fi
fi

################################################################################

if [[ $commands[fzf] ]]; then
  if [[ $commands[ag] ]]; then
    # Set `ag` as the default source for `fzf`
    export FZF_DEFAULT_COMMAND='ag -g ""'

    # Apply the command to CTRL-T as well
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  # => Set hotkeys for some widgets (assuming they are already defined).

  if typeset -f fzf-file-widget > /dev/null; then
    bindkey '^T' fzf-file-widget
  else
    echo '> Widget "fzf-file-widget" is not defined: skipping..'
  fi

  if typeset -f fzf-cd-widget > /dev/null; then
    bindkey '^E' fzf-cd-widget
  else
    echo '> Widget "fzf-cd-widget" is not defined: skipping..'
  fi

  if typeset -f fzf-history-widget > /dev/null; then
    bindkey '^R' fzf-history-widget
  else
    echo '> Widget "fzf-history-widget" is not defined: skipping..'
  fi

  # Set hotkeys for widgets defined in this file (=> they are always present).
  zle     -N   fzf-preview-widget
  bindkey '^Y' fzf-preview-widget
fi


# vim: set filetype=zsh :
