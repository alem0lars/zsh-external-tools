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


__fsel() {
  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__fzf_use_tmux__() {
  [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
}

__fzfcmd() {
  __fzf_use_tmux__ &&
    echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

# Ensure precmds are run after cd
function fzf-redraw-prompt() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}
zle -N fzf-redraw-prompt

function fzf-preview-widget() {
  local opts="${FZF_DEFAULT_OPTS} --preview-window right:70% --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {}) 2> /dev/null | head -500'"
  local height="98%"

  LBUFFER="${LBUFFER}$(FZF_DEFAULT_OPTS="${opts}" FZF_TMUX_HEIGHT="${height}" __fsel)"

  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-preview-widget

function fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-file-widget

# cd into the selected directory
function fzf-cd-widget() {
  local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  cd "$dir"
  local ret=$?
  zle fzf-redraw-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-cd-widget

# Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(fc -rl 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-history-widget

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

  bindkey '^T' fzf-file-widget
  bindkey '^E' fzf-cd-widget
  bindkey '^R' fzf-history-widget

  # Set hotkeys for widgets defined in this file (=> they are always present).
  bindkey '^Y' fzf-preview-widget
fi


# vim: set filetype=zsh :
