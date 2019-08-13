autoload -U colors
colors

setopt prompt_subst

# all stolen from oh-my-zsh's git library
# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# Compares the provided version of git to the version installed and on path
# Outputs -1, 0, or 1 if the installed version is less than, equal to, or
# greater than the input version, respectively.
function git_compare_version() {
  local INPUT_GIT_VERSION INSTALLED_GIT_VERSION
  INPUT_GIT_VERSION=(${(s/./)1})
  INSTALLED_GIT_VERSION=($(command git --version 2>/dev/null))
  INSTALLED_GIT_VERSION=(${(s/./)INSTALLED_GIT_VERSION[3]})

  for i in {1..3}; do
    if [[ $INSTALLED_GIT_VERSION[$i] -gt $INPUT_GIT_VERSION[$i] ]]; then
      echo 1
      return 0
    fi
    if [[ $INSTALLED_GIT_VERSION[$i] -lt $INPUT_GIT_VERSION[$i] ]]; then
      echo -1
      return 0
    fi
  done
  echo 0
}

# This is unlikely to change so make it all statically assigned
POST_1_7_2_GIT=$(git_compare_version "1.7.2")
# Clean up the namespace slightly by removing the checker function
unfunction git_compare_version

colnames=(
    black
    red
    green
    yellow
    blue
    magenta
    cyan
    white
    default
)

# Create color variables for foreground and background colors
for color in $colnames; do
    eval f$color='%{${fg[$color]}%}'
    eval b$color='%{${bg[$color]}%}'
done

# Hash the hostname and return a fixed "random" color
function _deterministic_colorize() {
    local chash=0
    foreach letter ( ${(ws::)1[(ws:.:)1]} )
        (( chash += #letter ))
    end
    local crand=$(( $chash % $#colnames ))
    local crandname=$colnames[$crand]
    echo "%{${fg[$crandname]}%}"
}
hostname_color=$(_deterministic_colorize $HOST)

# Add git info functions
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M'
zstyle ':vcs_info:*' unstagedstr 'M'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}(%F{2}%b%F{5}) %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}??%f'
fi
}

DATECMD=date
if [ x${ZLS_OS} = x"Mac" ]; then
  DATECMD=gdate
fi

# track execution time
preexec() {
    timer=$(($(${DATECMD} +%s%N)/1000000))
}

precmd () {
    vcs_info
    if [ $timer ]; then
        now=$(($(${DATECMD} +%s%N)/1000000))
        elapsed=$(($now-$timer))
        export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
        unset timer
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%})"
NEWLINE=$'\n'
local ret_status="%(?:%{$fg_bold[green]%}» :%{$fg_bold[red]%}» )"
function _prompt() {
    local timestamp="[%*]"
    local hostname="${fdefault}%n@${hostname_color}%m${fdefault}"
    local context=$($HOME/bin/get-current-context)
    local context_for_prompt=""
    if [ -n "${context}" ]; then
        context_for_prompt="(c:$(_deterministic_colorize ${context})${context}${fdefault}) "
    fi
    echo "${timestamp} ${hostname}:${context_for_prompt}%~ $(git_prompt_info)%f${ret_status}%{$reset_color%}${NEWLINE} $ "
}

PROMPT='$(_prompt)'

