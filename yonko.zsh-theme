git_commit_id() {
  command git rev-parse --short HEAD 2>/dev/null
}

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{cyan}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✹%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Virtualenv
VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="("
ZSH_THEME_VIRTUALENV_SUFFIX=") "

# Compact commit display
git_commit_prompt() {
  local commit=$(git_commit_id)
  if [ -n "$commit" ]; then
    echo " [%F{gray}${commit}%f]"
  fi
}

# Show only the last two segments of $PWD, with color
short_pwd() {
  local dir="${PWD/#$HOME/~}"
  local short=$(echo "$dir" | awk -F/ '{
    if (NF >= 2) print $(NF-1) "/" $NF;
    else print $NF
  }')
  echo "%F{green}${short}%f"
}

# Final prompt
PROMPT='$(virtualenv_prompt_info)$(short_pwd) | $(git_prompt_info)$(git_commit_prompt)
%F{red}$%f '
RPROMPT=''
