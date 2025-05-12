# Git prompt settings with Git symbol
ZSH_THEME_GIT_PROMPT_PREFIX="%F{81}⌥ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✹%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Virtualenv icon
VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="%F{yellow}(venv "
ZSH_THEME_VIRTUALENV_SUFFIX=") "

# Show only last two directories in path
short_pwd() {
  local dir="${PWD/#$HOME/~}"
  local short=$(echo "$dir" | awk -F/ '{
    if (NF >= 2) print $(NF-1) "/" $NF;
    else print $NF
  }')
  echo "%F{76}🗂  ${short}%f"
}

# SSH lock icon if over SSH
ssh_lock_prompt() {
  [[ -n "$SSH_CONNECTION" ]] && echo "%F{magenta}🔒%f "
}

# Virtualenv display
virtualenv_prompt_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "${ZSH_THEME_VIRTUALENV_PREFIX}${ZSH_THEME_VIRTUALENV_SUFFIX}"
  fi
}

# Get short Git commit ID
git_commit_id() {
  command git rev-parse --short HEAD 2>/dev/null
}

# Git commit hash display
git_commit_prompt() {
  local commit=$(git_commit_id)
  [[ -n "$commit" ]] && echo " %F{75}[%f%F{75}${commit}%f%F{75}]%f"
}

# Check if current directory is ~
is_home() {
  local dir="${PWD/#$HOME/~}"
  [[ "$dir" == "~" ]]
}

git_prompt_info() {
  ref=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n "$ref" ]]; then
    # Check if the repo is dirty
    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
      dirty=$ZSH_THEME_GIT_PROMPT_DIRTY
    else
      dirty=$ZSH_THEME_GIT_PROMPT_CLEAN
    fi
    echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref}${dirty}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
  fi
}

# Dynamically set PROMPT: one-line in ~, two-line elsewhere
set_prompt() {
  local ssh_part='$(ssh_lock_prompt)'
  local venv_part='$(virtualenv_prompt_info)'
  local dir_part='$(short_pwd)'
  local git_part='$(git_prompt_info)$(git_commit_prompt)'
  local prompt_end='%F{87}⌘%f '

  if is_home; then
    PROMPT="${venv_part}${dir_part} ${git_part} ${prompt_end} "
  else
    PROMPT="${venv_part}${dir_part} ${git_part}"$'\n'"${prompt_end} "
  fi
  
  RPROMPT="${ssh_part}"
}

# Update prompt before each command
precmd_functions+=(set_prompt)
# Update prompt befor dir change command
chpwd_functions+=(set_prompt)

# Disable right prompt
