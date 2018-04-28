#!/bin/zsh
# Alt+dでfileのあいまい検索を行い、そのファイルがあるディレクトリにcd
# fzf-cd-widget(Alt+c)ではディレクトリ検索しかできなかった点を改造

# ALT-D - cd into the directory contained selected file
fzf-cd-basename-widget() {
    dirname $(fd --type f | fzf) | cd
    local ret=$?
    zle fzf-redraw-prompt
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle -N fzf-cd-basename-widget
bindkey '\ed' fzf-cd-basename-widget
