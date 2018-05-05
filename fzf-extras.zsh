#!/bin/zsh
if [[ $- =~ i ]]; then

# ALT-I - Paste the selected entry from locate output into the command line
fzf-locate-widget() {
  local selected
  if selected=$(locate / | fzf -q "$LBUFFER"); then
    LBUFFER=$selected
  fi
  zle redisplay
}
zle     -N    fzf-locate-widget
bindkey '\ei' fzf-locate-widget

fi


# Ctrl+Rで$HISTORY_FILEのあいまい検索および実行
# `HISTORY_FILTER=fzy -l 40`などとして、フィルターを変更できます
function fzf-history() {
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
    # NOTE neet space at the first string
    case $HISTORY_FILTER in
      'fzf-tmux') HISTORY_FILTER+=' --reverse --no-sort' ;;
      'fzy')      HISTORY_FILTER+=' -l 20'               ;;
      'fzf')      HISTORY_FILTER+=' --no-sort'           ;;
    esac
  fi

  # [MAIN] Select history using FuzzyFinder
  BUFFER=$(history -n 1 | eval $tac | eval "$HISTORY_FILTER --query '$LBUFFER'")
  CURSOR=$#BUFFER

  zle reset-prompt
}

zle -N fzf-history
bindkey '^r' fzf-history
