# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local IFS=$'\n'
  local files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && echo "${EDITOR:-vim} ${files[@]}" | runcmd
}

# Modified version of fe() where you can press
#   - CTRL-O to open with `xdg-open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local IFS=$'\n'
  local out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  local key=$(head -1 <<< "$out")
  local file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fzf --preview command for file and directory
if type pygmentize >/dev/null 2>&1; then
    FZF_PREVIEW_CMD='head -n $FZF_PREVIEW_LINES {} | pygmentize -g'
elif type bat >/dev/null 2>&1; then
    FZF_PREVIEW_CMD='bat --color=always --plain --line-range :$FZF_PREVIEW_LINES {}'
else
    FZF_PREVIEW_CMD='head -n $FZF_PREVIEW_LINES {}'
fi

# zd - cd into selected directory with options
# The super function of _fd, _fda, _fdr, _fst, _cdf, _zz
# ctrl-v toggle preview window
zd() {
    usage() {
        echo "usage: zd [OPTIONS]"
        echo "\tzd: cd to selected options below"
        echo "OPTIONS:"
        echo "\t-d [path]: Directory (default)"
        echo "\t-a [path]: Directory included hidden"
        echo "\t-r [path]: Parent directory"
        echo "\t-s [query]: Directory from stack"
        echo "\t-f [query]: Directory of the selected file"
        echo "\t-z [query]: Frecency directory"
        echo "\t-h: Print this usage"
    }

    # No arg
    if [ ! $1 ]; then
        _fd
    # Args is '..' or '-' or [path]
    elif [ $1 = '..' ]; then
        shift; _fdr $1
    elif [ $1 = '-' ]; then
        shift; _fst "$*"
    elif [ ${1:0:1} != '-' ]; then  # first string is not -
        _fd $(realpath $1)
    # Args is start from '-'
    else
        while getopts darfszh OPT; do
            case $OPT in
                d) shift; _fd  $1; return 0;;
                a) shift; _fda $1; return 0;;
                r) shift; _fdr $1; return 0;;
                s) shift; _fst "$*"; return 0;;
                f) shift; _cdf "$*"; return 0;;
                z) shift; _zz  "$*"; return 0;;
                h) usage; return 0;;
                *) usage; return 1;;
            esac
        done
    fi
}


# _fd - cd to selected directory
_fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null |
          fzf +m \
              --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
              --preview-window='right:hidden:wrap' \
              --bind=ctrl-v:toggle-preview \
              --bind=ctrl-x:toggle-sort \
              --header='<C-V> toggle preview <C-X> toggle sort' \
              ) && cd "$dir"
}

# _fda - including hidden directories
_fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null |
          fzf +m \
              --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
              --preview-window='right:hidden:wrap' \
              --bind=ctrl-v:toggle-preview \
              --bind=ctrl-x:toggle-sort \
              --header='<C-V> toggle preview <C-X> toggle sort' \
              ) &&
              cd "$dir"
}

# _fdr - cd to selected parent directory
_fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local dir
  dir=$(get_parent_dirs $(realpath "${1:-$PWD}") |
              fzf +m \
                  --preview 'tree -C {} | head -n $FZF_PREVIEW_LINES' \
                  --preview-window='right:hidden:wrap' \
                  --bind=ctrl-v:toggle-preview \
                  --bind=ctrl-x:toggle-sort \
                  --header='<C-V> toggle preview <C-X> toggle sort' \
                  ) && cd "$dir"
}

# _cdf - cd into the directory of the selected file
_cdf() {
   local file
   file=$(fzf +m -q "$*" \
            --preview=${FZF_PREVIEW_CMD} \
            --preview-window='right:hidden:wrap' \
            --bind=ctrl-v:toggle-preview \
            --bind=ctrl-x:toggle-sort \
            --header='<C-V> toggle preview <C-X> toggle sort' \
            ) && cd $(dirname "$file")
}

# _fst - cd into the directory from stack
_fst() {
    local dir
    dir=$(echo $dirstack |
            sed -e 's/\s/\n/g' |
            fzf +s +m -1 -q "$*" \
                --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
                --preview-window='right:hidden:wrap' \
                --bind=ctrl-v:toggle-preview \
                --bind=ctrl-x:toggle-sort \
                --header='<C-V> toggle preview <C-X> toggle sort' \
            )
    # check $dir exist for Ctrl-C interrapt
    # or change directory to $HOME (= no value cd)
    [ $dir ] && cd $dir
}

# utility function used to run the command in the shell
runcmd () {
  perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>'
}

# fh - repeat history
fh() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

# utility function used to write the command in the shell
writecmd () {
  perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do { chomp($_ = <>); $_ }'
}

# fhe - repeat history edit
fhe() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fbr - checkout git branch (including remote branches)
#   - sorted by most recent commit
#   - limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# git log browser
# %s: comment
# %d: branch/tag
# %h: hash
# %cd: date
# %an: author
fzf-gitlog-widget() {
    git_cmd="git log --all --graph --date-order\
    --format=format:'%C(auto)%s %d %h %C(cyan)%cd %C(bold black)%an %C(auto)'\
    --date=short --color=always"

    fzf_cmd="fzf --height=100% --ansi --reverse --no-sort --tiebreak=index\
    --bind=ctrl-x:toggle-sort\
    --bind \"ctrl-m:execute: (grep -o '[a-f0-9]\{7\}' | head -1 |
        xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
        {}
    FZF-EOF\""

    eval "$git_cmd | $fzf_cmd"
}

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
    --format=format:'%C(auto)%s %d %h %C(cyan)%cd %C(bold black)%an %C(auto)'\
    --date=short --color=always"

    fzf_cmd="fzf --height 100% --multi --ansi --reverse --no-sort --tiebreak=index\
    --bind=ctrl-x:toggle-sort"

    eval "$git_cmd | $fzf_cmd" |
        grep -o '[a-f0-9]\{7\}' |
            xargs -I % sh -c 'git show % --color' | cat
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-$COLUMNS | fzf --nth=2 --tiebreak=begin
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf-tmux --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

# e - open 'frecency' files in $VISUAL editor
# ctrl-v toggle preview window
# ctrl-x toggle sort
e() {
    local files
    files=($(fasd -fl |
                fzf --tac \
                    --reverse \
                    -1 \
                    --no-sort \
                    --multi \
                    --tiebreak=index \
                    --preview=${FZF_PREVIEW_CMD} \
                    --preview-window='right:hidden:wrap' \
                    --bind=ctrl-v:toggle-preview \
                    --bind=ctrl-x:toggle-sort \
                    --header='<C-V> toggle preview <C-X> toggle sort' \
                    --query "$*" |
                        awk '{print $2}'))
    [[ -n $files ]] && echo "${VISUAL:-vim} ${files[@]}" | runcmd || echo 'No file selected'
}

# _zz - selectable cd to frecency directory
# ctrl-v toggle preview window
# ctrl-x toggle sort
_zz() {
    local dir
    dir=$(fasd -dl |
            fzf --tac \
                --reverse \
                -1 \
                --no-sort \
                --no-multi \
                --tiebreak=index \
                --preview='tree -C {} | head -n $FZF_PREVIEW_LINES' \
                --preview-window='right:hidden:wrap' \
                --bind=ctrl-v:toggle-preview \
                --bind=ctrl-x:toggle-sort \
                --header='<C-V> toggle preview <C-X> toggle sort' \
                --query "$*" |
                    awk '{print $2}')
    [ $dir ] && cd $dir
}
