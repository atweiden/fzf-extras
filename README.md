fzf-extras
==========
# Installation
## Use zplug
If you use [zplug](https://github.com/zplug/zplug), write on your .zshrc

```
zplug "u1and0/fzf-extras",\
    on:"clvv/fasd",\
    use:"fzf*"
# Recomend options
alias zz='zd -z $*'
alias gz='fzf-gitlog-widget'
alias gx='fzf-gitlog-multi-widget'
```

...and reload shell `$SHELL -l`


## Use git
Or from my github repository

```
git clone https://github.com/u1and0/fzf-extras
cd ./fzf-extras
source fzf-extra.sh
source fzf-extra.zsh
```

# Dependency
* [clvv/fasd](https://github.com/clvv/fasd)
* [junegunn/fzf-bin](https://github.com/junegunn/fzf)
* [tmux/tmux](https://github.com/tmux/tmux)


## Archlinux
Use pacman on archlinux OS

```
pacman -S fasd fzf tmux
```


## zplug
Or use [zplug](https://github.com/zplug/zplug)

```
# fasd
zplug "clvv/fasd", as:command, use:fasd

# fzf
zplug "junegunn/fzf-bin",\
    as:command,\
    from:gh-r,\
    rename-to:"fzf",\
    hook-load:"source $ZPLUG_REPOS/junegunn/fzf/shell/key-bindings.zsh;\
               source $ZPLUG_REPOS/junegunn/fzf/shell/completion.zsh"
# Recomend options
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--ansi --height 40% --reverse --no-border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# tmux
# I don't know how... please tell me anyone
```


# Additional key bindings for fzf, primarily Bash.

bash cmdline         | description
---                  | ---
`zd`                 | 'fuzzy-finder' + 'cd' = 'zd', The super function of _fd, _fda, _fdr, _fst, _cdf, _zz
`_fd`                | cd into selected directory
`_fda`               | cd into selected directory, including hidden directories
`_fdr`               | cd into selected parent directory
`_fst`               | cd into the directory from stack
`_cdf`               | cd into the directory of the selected file
`_zz`                | selectable cd to frecency directory
`fbr`                | Checkout Git branch (including remote branches)
`fco`                | Checkout Git branch/tag
`fcoc`               | Checkout Git commit
`fcs`                | Get Git commit SHA hash
`fe [FUZZY PATTERN]` | Open the selected file with the default editor
`fh`                 | Select line from history, repeat without editing
`fhe`                | Select line from history, leave for editing
`fkill`              | Select process to kill (alternatively, type `kill`˽<kbd>Tab</kbd>)
`fo`                 | Equivalent to `fe`, but opens it with `xdg-open` if you press <kbd>Ctrl+O</kbd>
`fs [FUZZY PATTERN]` | Select tmux session
`fshow`              | Git commit browser
`fstash`             | Git stash management (<kbd>Enter</kbd> to show contents of the stash, <kbd>Ctrl+D</kbd> to show a diff of the stash against your current HEAD, <kbd>Ctrl+B</kbd> to check the stash out as a branch, for easier merging)
`fzf-gitlog-widget`  | git log browser
`fzf-gitlog-multi-widget` | Multi-Selectable git show
`ftags`              | Search ctags
`ftpane`             | Switch pane
`v`                  | Open files in `~/.viminfo`
`runcmd`             | Utility function used to run the command in the shell
`writecmd`           | Utility function used to write the command in the shell
`e`                  | Open 'frecency' files in $VISUAL editor


zsh cmdline      | description
---              | ---
<kbd>Alt-i</kbd> | Paste the selected entry from `locate` output into the command line


Sources
-------

- [fzf wiki](https://github.com/junegunn/fzf/wiki)
- [junegunn/dotfiles](https://github.com/junegunn/dotfiles)


See Also
--------

- [DanielFGray/fzf-scripts](https://github.com/DanielFGray/fzf-scripts)
- [clvv/fasd](https://github.com/clvv/fasd)
- [junegunn/fzf-bin](https://github.com/junegunn/fzf)
- [tmux/tmux](https://github.com/tmux/tmux)
- [b4b4r07/enhancd](https://github.com/b4b4r07/enhancd)
- [rupa/z](https://github.com/rupa/z)


License
-------

[MIT](LICENSE)
