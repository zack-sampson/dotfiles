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

# Add git info functions
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

# track execution time
preexec() {
    timer=$(($(date +%s%N)/1000000))
}

precmd () {
    vcs_info
    if [ $timer ]; then
        now=$(($(date +%s%N)/1000000))
        elapsed=$(($now-$timer))
        export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
        unset timer
    fi
}

NEWLINE=$'\n'
PROMPT='[%*] ${fdefault}[%n@${hostname_color}%m${fdefault}]:%3~ ${vcs_info_msg_0_} %f${NEWLINE} $ '
