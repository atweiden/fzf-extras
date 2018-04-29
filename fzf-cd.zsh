#!/bin/zsh
# fileのあいまい検索を行い、そのファイルがあるディレクトリにcd
# fzf-cd-widget(Alt+c)ではディレクトリ検索しかできなかった点を改造

# ALT-G - cd into the directory contained selected file
fzf-cd-basename-widget() {
    dirname $(rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null | fzf) | cd
    local ret=$?
    zle fzf-redraw-prompt
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle -N fzf-cd-basename-widget
bindkey '\eg' fzf-cd-basename-widget
