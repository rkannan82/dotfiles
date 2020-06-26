########################################
# go/goog_prompt
#
# version: 1.1
# author: Justin Bishop
# email: jubi@google.com
########################################

##### BEGIN ENV settings #####

# Space reserved between left and right prompt.
export -i PROMPT_SPACE=${PROMPT_SPACE:-41}

# The start of our left prompt
export PROMPT_PREFIX=${PROMPT_PREFIX:-$USER}

# Hours before we care about staleness
export -i STALENESS_THRESHOLD=${STALENESS_THRESHOLD:-20}

# Prompt colors
typeset -Ag clr=(
  path 123
  wkspace 207
  src 39
  home 154
  prefix 190
  warn white
  warn_bg 196
  p4head 1
	tip 154
  patched 165
  icons white
	stale 207
  author 45
  div white
  cl_updated green
  cl_willupdate yellow
  desc green
)

export cloudHome="/google/src/cloud/$USER"

##### END ENV settings #####

##### BEGIN Workspace identification #####

# Workspace name
function workspace() {
  if [[ $PWD =~ "$cloudHome/([^/]+)" ]]; then
    echo ${match[1]}
  fi
}

# Absolute directory of our workspace
function workspace_dir() {
  if [[ $WORKSPACE != "" ]]; then
    echo "$cloudHome/$WORKSPACE/google3"
  fi
}

# Relative path after google3/
function source_pwd() {
  local wkspace_dir=$(workspace_dir)
  if [[ -n "$wkspace_dir" ]]; then
    echo "$PWD[${#wkspace_dir}+2,${#PWD}]"
  fi
}

##### END Workspace identification #####

##### BEGIN VCS analysis #####

# Clears out our exported vars
function unset_vcs_info() {
  unset AUTHOR CHANGELIST COMMIT_MESSAGE
  RPROMPT=""
  typeset -Ag VCS_STATUS=()
}

# Kicks off async request for vcs info
function fetch_vcs_info() {
  unset_vcs_info
  if [[ -z $WORKSPACE || ! -d $cloudHome/$WORKSPACE/.hg ]]; then return; fi

  async_worker_eval vcs_worker cd $PWD
	async_job vcs_worker eval 'chg log --rev p4base -T "{date}\n"; chg log --follow -l 1 -T "{author}\n:{parents}\n:{clnumber}\n:{p4head}\n:{patchedcl}\n:{tags}\n:{willupdatecl}\n{GOOG_trim_desc(desc)}"'
}

# exports $AUTHOR $CHANGELIST $COMMIT_MESSAGE $VCS_STATUS
function update_vcs_info() {
  unset_vcs_info

  # If we got an error, we need to kick off the service again
  if [[ $2 -ne 0 ]]; then
    async_stop_worker vcs_worker
    async_unregister_callback vcs_worker
    async_flush_jobs vcs_worker
    async_start_worker vcs_worker
    async_register_callback vcs_worker update_vcs_info
    fetch_vcs_info
    return
  fi

  if [[ $1 != "eval" || -z $WORKSPACE ]]; then return; fi

  # If there's already another queued, we throw this one away
  if [[ $6 -eq 1 ]]; then return; fi

  # Extract values from reply
  local -a values=("${(f)3}")
  local -i p4date=$values[1]
  export AUTHOR=$values[2]
  local -a parents=(${=values[3]})
  if [[ $values[4] =~ "\b([0-9]+)\b" ]]; then
    export CHANGELIST="cl/$match[1]"
  fi
  local p4head=$values[5]
  local patchedcl=$values[6]
  local tags=$values[7]
  local willupdatecl=$values[8]
  export COMMIT_MESSAGE=$values[9]

  # Set various VCS_STATUS
  local -i now=$(date +"%s")
  local -i diff; ((diff = ($now - $p4date) / 3600))
  if [[ $diff -ge $STALENESS_THRESHOLD ]]; then
    VCS_STATUS[stale]=$diff
  fi
  if [[ $#parents -ge 2 ]]; then
    VCS_STATUS[merge]=1
  fi
  if [[ $p4head == ":p4head" ]]; then
    VCS_STATUS[p4head]=1
  fi
  if [[ $tags =~ "\btip\b" ]]; then
    VCS_STATUS[tip]=1
  fi
  if [[ $willupdatecl =~ "\b([0-9]+)\b" ]]; then
    VCS_STATUS[willupdatecl]=1
    export CHANGELIST="cl/$match[1]"
  fi
  if [[ $patchedcl =~ "\b([0-9]+)\b" ]]; then
    VCS_STATUS[patched]=1
    export CHANGELIST="cl/$match[1]"
  fi

  # Update the prompt then tell ZSH to redraw it
  update_rprompt
  zle && zle reset-prompt
}

# Updated in precmd, used to track fig changes
local vcs_mtime=''
function get_vcs_mtime() {
  case `uname` in
    Darwin)
      statArgs="-f%c"
    ;;
    Linux)
      statArgs="-c %Z"
    ;;
  esac
  local mtime=""
  if [[ -f $cloudHome/$WORKSPACE/.hg/dirstate ]]; then
    mtime+="$(stat $statArgs $cloudHome/$WORKSPACE/.hg/dirstate)"
  fi
  if [[ -f $cloudHome/$WORKSPACE/.hg/store/review__units ]]; then
    mtime+="-$(stat $statArgs $cloudHome/$WORKSPACE/.hg/store/review__units)"
  fi
  echo $mtime
}

# Setup async worker for getting VCS info
async_start_worker vcs_worker
async_register_callback vcs_worker update_vcs_info

##### END VCS analysis #####

##### BEGIN Prompt management #####

# Updated by update_prompt
local -i PROMPT_SIZE=0

# Update rprompt
function update_rprompt() {
  RPROMPT=""
  if [[ -z $WORKSPACE || -z $vcs_mtime ]]; then return; fi

  # Calculate total columns available for rprompt
  local -i avail_columns
  ((avail_columns = $COLUMNS - $PROMPT_SIZE - $PROMPT_SPACE))

  # If we're stale, display the stale symbol, +3 for 🕑h
  if [[ -n $VCS_STATUS[stale] ]]; then
    RPROMPT+="%F{$clr[stale]}🕑$VCS_STATUS[stale]h %f"
    ((avail_columns = $avail_columns - $#VCS_STATUS[stale] - 3))
  fi

  # If we're at tip, display the tip symbol, +2 for ➳
  if [[ $VCS_STATUS[tip] -eq 1 ]]; then
    RPROMPT+="%F{$clr[tip]}➳ %f"
    ((avail_columns = $avail_columns - 1))
  fi

  # If we're at p4head, display the p4head symbol, +2 for ☽
  if [[ $VCS_STATUS[p4head] -eq 1 ]]; then
    RPROMPT+="%F{$clr[p4head]}☽ %f";
    ((avail_columns = $avail_columns - 1))
  fi

  # If we're a patch, display the patch symbol, +2 for ℞
  if [[ $VCS_STATUS[patched] -eq 1 ]]; then
    RPROMPT+="%F{$clr[patched]}℞ %f"
    ((avail_columns = $avail_columns - 1))
  fi

  # We show evil merge warning no matter what, then end it.
  if [[ $VCS_STATUS[merge] -eq 1 ]]; then
    RPROMPT+="❗%K{$clr[warn_bg]}%F{$clr[warn]}%BDon't amend! (Evil Merge)%b%f%k"
    return
  fi

  # Display author if it's not us, +1 for 🙋
  if [[ $AUTHOR != "$USER@google.com" && $avail_columns -ge (($#AUTHOR + 1)) ]]; then
    RPROMPT+="🙋%F{$clr[author]}$AUTHOR%f"
    ((avail_columns = $avail_columns - $#AUTHOR - 1))
  fi

  # Add our changelist, +1 for ✔
  if [[ -n $CHANGELIST && $avail_columns -ge (($#CHANGELIST + 1)) ]]; then
    RPROMPT+="%F{$clr[icons]}✔"
    if [[ $VCS_STATUS[willupdatecl] -eq 1 ]]; then
      RPROMPT+="%F{$clr[cl_willupdate]}$CHANGELIST%f"
    else
      RPROMPT+="%F{$clr[cl_updated]}$CHANGELIST%f"
    fi
    ((avail_columns = $avail_columns - $#CHANGELIST - 1))
  fi

  # End if there's no commit_mesage or we're out of space
  if [[ -z $COMMIT_MESSAGE || $avail_columns -lt 5 ]]; then return; fi

  # Do we need to shorten the commit message? +2 for  ✐
  if [[ $avail_columns -lt (($#COMMIT_MESSAGE + 2)) ]]; then
    local short_commit="$COMMIT_MESSAGE[1, (($avail_columns - 4))].."
    RPROMPT+="%F{$clr[icons]} ✐%F{$clr[desc]}$short_commit%f"
  else
    RPROMPT+="%F{$clr[icons]} ✐%F{$clr[desc]}$COMMIT_MESSAGE%f"
  fi
}

# Update prompt
function update_prompt() {
  PROMPT="%F{green}⇪%F{$clr[prefix]}$PROMPT_PREFIX%F{$clr[div]}:%f"
  ((PROMPT_SIZE = $#PROMPT_PREFIX + 2)) # 2 for "⇪:"

  if [[ $PWD == $HOME ]]; then # If we're in $HOME, just show 🏠
    PROMPT+="🏠"
    ((PROMPT_SIZE = PROMPT_SIZE + 1))
  elif [[ $PWD == $HOME* ]]; then # Or relative path to 🏠
    local rel_home="$(realpath --relative-to=$HOME $PWD)"
    PROMPT+="🏠%F{$clr[home]}$rel_home%f"
    ((PROMPT_SIZE = PROMPT_SIZE + $#rel_home + 1))
  elif [[ $PWD == $(workspace_dir) ]]; then # Or just $WORKSPACE
    PROMPT+="%F{$clr[wkspace]}%B$WORKSPACE%b%f"
    ((PROMPT_SIZE = PROMPT_SIZE + $#WORKSPACE))
  else
    local src_pwd=$(source_pwd)
    if [[ -n $src_pwd ]]; then # Show relative path to workspace
      PROMPT+="%F{$clr[wkspace]}%B$WORKSPACE%b%F{$clr[div]}/%F{$clr[src]}$src_pwd%f"
      ((PROMPT_SIZE = PROMPT_SIZE + $#WORKSPACE + $#src_pwd + 1))
    else
      # Not in $WORKSPACE or $HOME, show absolute path up to 50 chars.
      PROMPT+="%F{$clr[path]}%50<..<%~%f"
      if [[ $#PWD -gt 50 ]]; then
        ((PROMPT_SIZE = PROMPT_SIZE + 50))
      else
        ((PROMPT_SIZE = PROMPT_SIZE + $#PWD))
      fi
    fi
  fi

  ((PROMPT_SIZE = PROMPT_SIZE + 2)) # 2 = "#>"
  PROMPT+="%F{$clr[div]}#>%f"
}

# add-zsh-hook to hook into chpwd and precmd
autoload -Uz add-zsh-hook

# Track when PWD/WORKSPACE has changed to update prompt
function pwd_changed() {
  # Mark if workspace has changed
  unset WORKSPACE_CHANGED
  local new_workspace=$(workspace)
  if [[ $new_workspace != $WORKSPACE ]]; then
    export WORKSPACE=$new_workspace
    export WORKSPACE_CHANGED=0
  fi

  # Mark that PWD changed, and update left prompt
  export PWD_CHANGED=0 && update_prompt
}
add-zsh-hook chpwd pwd_changed

# Run before every command, to determine whether rprompt needs updating
function prompt_precmd() {
	# Initial prompt setting
	if [[ $PROMPT_SIZE -eq 0 ]]; then pwd_changed; fi

  # Update if our WORKSPACE changed
  if [[ -n $WORKSPACE_CHANGED ]]; then
    if [[ -n $WORKSPACE ]]; then
      vcs_mtime=$(get_vcs_mtime)
    else vcs_mtime=''; fi
    fetch_vcs_info
  elif [[ -n $WORKSPACE ]]; then
    # Update if .hg has been changed
    local new_mtime=$(get_vcs_mtime)
    if [[ $new_mtime != $vcs_mtime ]]; then
      vcs_mtime=$new_mtime
      fetch_vcs_info
    elif [[ -n $PWD_CHANGED ]]; then update_rprompt; fi
  elif [[ -n $PWD_CHANGED ]]; then update_rprompt; fi

  # Unset this for tracking next cycle
  unset PWD_CHANGED WORKSPACE_CHANGED
}
add-zsh-hook precmd prompt_precmd

# If the terminal resizes, we need to rerun update_rprompt
function window_changed() {
  update_rprompt
  zle && zle reset-prompt
}
trap window_changed WINCH

##### END Prompt management #####
