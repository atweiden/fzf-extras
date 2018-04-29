#!/bin/zsh
# git log の選択的インターフェース

# git log browser
fzf-gitlog-widget() {
    git_cmd="git log --all --graph --date-order\
    --format=format:'%C(yellow)%h %C(bold green)%cd %C(reset)%s\
    %C(auto)%d %C(reset)' --date=format:'%Y-%m-%d %H:%M:%S' --color=always"
    fzf_cmd="fzf --ansi --reverse --no-sort --tiebreak=index"
    eval "$git_cmd | $fzf_cmd"

    local ret=$?
    zle fzf-redraw-prompt
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
    zle -N fzf-gitlog-widget
}
# bindkey '\eg' fzf-cd-basename-widget
