# Git prompt settings with Git symbol
ZSH_THEME_GIT_PROMPT_PREFIX="%F{81} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✹%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Virtualenv icon
VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="%F{yellow}venv("
ZSH_THEME_VIRTUALENV_SUFFIX=")%f "

is_home() {
  if [[ "$dir" == "~" ]]; then
    return true
  else
    return false
  fi
}

# Get short Git commit ID
git_commit_id() {
  command git rev-parse --short HEAD 2>/dev/null
}

# Git commit hash display
git_commit_prompt() {
  local commit=$(git_commit_id)
  if [ -n "$commit" ]; then
    echo " %F{75}[%f%F{75}${commit}%f%F{75}]%f"
  fi
}

# Show only last two dirs with folder icon (fully green)
short_pwd() {
  local dir="${PWD/#$HOME/~}"
  local short=$(echo "$dir" | awk -F/ '{
    if (NF >= 2) print $(NF-1) "/" $NF;
    else print $NF
  }')
  echo "%F{88} /${short}%f"
}

# SSH lock icon if over SSH
ssh_lock_prompt() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo "%F{magenta}🔒%f "
  fi
}

# Dynamically set PROMPT: one-line in ~, two-line otherwise
set_prompt() {
  local dir="${PWD/#$HOME/~}"

  local ssh_part='$(ssh_lock_prompt)'
  local venv_part='$(virtualenv_prompt_info)'
  local dir_part='$(short_pwd)'
  local git_part='$(git_prompt_info)$(git_commit_prompt)'
  local prompt_end='%F{87}$%f'

  if is_home(); then
    PROMPT="${ssh_part}${venv_part}${dir_part} ${git_part} ${prompt_end} "
  else
    PROMPT="${ssh_part}${venv_part}${dir_part} ${git_part}"$'\n'"${prompt_end} "
  fi
}

# Update prompt before each command
precmd_functions+=(set_prompt)

# No right prompt
RPROMPT=''
