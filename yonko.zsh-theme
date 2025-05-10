git_commit_id() {
  command git rev-parse --short HEAD 2>/dev/null
}

# Git prompt settings with Git symbol
ZSH_THEME_GIT_PROMPT_PREFIX="%F{81} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✹%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Virtualenv icon
VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="%F{yellow}venv("
ZSH_THEME_VIRTUALENV_SUFFIX=")%f "

# Commit hash display
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

ssh_lock_prompt() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo "%F{magenta}🔒%f "
  fi
}


# Final prompt
PROMPT='$(ssh_lock_prompt)$(virtualenv_prompt_info)$(short_pwd) $(git_prompt_info)$(git_commit_prompt)
%F{87}$%f '

RPROMPT=''
