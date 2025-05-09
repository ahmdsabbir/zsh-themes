git_commit_id() {
  command git rev-parse --short HEAD 2>/dev/null
}

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✹%f"       # Dirty indicator
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Virtualenv settings (comes FIRST)
VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="%F{yellow}🐍%f"   # Snake with color
ZSH_THEME_VIRTUALENV_SUFFIX=""

# Compact commit display
git_commit_prompt() {
  local commit=$(git_commit_id)
  if [ -n "$commit" ]; then
    echo " %F{240}[%f%F{gray}${commit}%f%F{240}]%f"
  fi
}

# Final prompt - venv first, then git, then commit
PROMPT='$(virtualenv_prompt_info)$(git_prompt_info)$(git_commit_prompt) %F{white}$%f '

# Disable right prompt
RPROMPT=''