# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="aussiegeek"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git brew tmux)

#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='kak'
else
  export EDITOR='kak'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set up cargo (rust package manager)
if [ -d $HOME/.cargo ] ; then
  if [ -f $HOME/.cargo/env ] ; then
    source $HOME/.cargo/env
  fi
fi

if command -v most > /dev/null 2>&1 ; then
  export PAGER=most
  alias less=$PAGER
fi

if [ -d $HOME/bin ] ; then
  export PATH=$HOME/bin:$PATH
fi

LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

# prompt
# assign a prompt color by hashing the letters of the hostname
# idea copied from the irssi script 'nickcolor.pl'
# Daniel Kertesz <daniel@spatof.org>

autoload -U colors
colors

setopt prompt_subst

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
function _hostname_color() {
    local chash=0
    foreach letter ( ${(ws::)HOST[(ws:.:)1]} )
        (( chash += #letter ))
    end
    local crand=$(( $chash % $#colnames ))
    local crandname=$colnames[$crand]
    echo "%{${fg[$crandname]}%}"
}
hostname_color=$(_hostname_color)

autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M'
zstyle ':vcs_info:*' unstagedstr 'M'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}[%F{2}%b%F{5}] %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}??%f'
fi
}

precmd () { vcs_info }
#PROMPT='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_} %f%# #'
#PROMPT='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_mg_0_} %f%# '
NEWLINE=$'\n'
PROMPT='[%*] ${fdefault}[%n@${hostname_color}%m${fdefault}]:%3~ ${vcs_info_msg_0_} %f${NEWLINE} $ '
#PROMPT='${hostname_color}%n${fdefault}@${hostname_color}%m${fdefault} %#'

alias g="git"
