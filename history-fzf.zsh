#!/bin/zsh
# Ctrl+Rで$HISTORY_FILEのあいまい検索および実行
# `HISTORY_FILTER=fzy -l 40`などとして、フィルターを変更できます
function history-fzf() {
  local tac
  if which tac > /dev/null; then  # for Linux
    tac="tac"
  else
    tac="tail -r"  # for Mac
  fi

  # Set the HISTORY_FILTER if empty
  if [ ! $HISTORY_FILTER ]; then
    if [ $TMUX ]; then
      FILTERS=( fzf-tmux peco-tmux )
    else
      FILTERS+=( fzy fzf peco)
    fi

    # Select filter
    for HISTORY_FILTER in ${FILTERS[@]}; do
      if which $HISTORY_FILTER > /dev/null 2>&1; then
        break
      fi
    done

    # Set HISTORY_FILTER option
    case $HISTORY_FILTER in
      'fzf-tmux') HISTORY_FILTER+=' --reverse' ;;
      'fzy')      HISTORY_FILTER+=' -l 20'     ;;
    esac
  fi

  # [MAIN] Select history using FuzzyFinder
  BUFFER=$(history -n 1 | eval $tac | eval "$HISTORY_FILTER --query '$LBUFFER'")
  CURSOR=$#BUFFER

  zle reset-prompt
}

zle -N history-fzf
bindkey '^r' history-fzf
