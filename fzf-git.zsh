#!/bin/zsh
# git log の選択的インターフェース

# git log browser
fzf-gitlog-widget() {
    git_cmd="git log --all --graph --date-order\
    --format=format:'%C(yellow)%h %C(reset)%s %C(bold black)%cd %C(auto)%d %C(reset)'\
    --date=short --color=always"

    fzf_cmd="fzf --ansi --reverse --no-sort --tiebreak=index\
    --bind=ctrl-x:toggle-sort\
    --bind \"ctrl-m:execute: (grep -o '[a-f0-9]\{7\}' | head -1 |
        xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
        {}
    FZF-EOF\""

    eval "$git_cmd | $fzf_cmd"

    local ret=$?
    zle fzf-redraw-prompt
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}

zle -N fzf-gitlog-widget


# Multi-Selectable git show
#
# 1. Show git log --graph
# 2. Fuzzy Search
# 3. Select Tab key
# 4. Enter, then push selected commit message into STDOUT
#
# You can use pipe like below
# ```
# fzf-gitlog-multi-widget | grep date  # Show only date
# fzf-gitlog-multi-widget | less -P 'hoge'  # Commit messege highlight 'hoge'
# ```
#
fzf-gitlog-multi-widget() {
    git_cmd="git log --all --graph --date-order\
    --format=format:'%C(yellow)%h %C(reset)%s %C(bold black)%cd %C(auto)%d %C(reset)'\
    --date=short --color=always"

    fzf_cmd="fzf --multi --ansi --reverse --no-sort --tiebreak=index\
    --bind=ctrl-x:toggle-sort"

    eval "$git_cmd | $fzf_cmd |
        grep -o '[a-f0-9]\{7\}' |
        xargs -I % sh -c 'git show % --color' | cat"

    local ret=$?
    zle fzf-redraw-prompt
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}

zle -N fzf-gitlog-multi-widget
