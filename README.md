fzf-extras
==========

Additional key bindings for fzf, primarily Bash.

Usage
-----

bash cmdline              | description
---                       | ---
`cdf`                     | cd into the directory of the selected file
`e`                       | Open 'frecency' files in `$VISUAL` editor
`fbr`                     | Checkout Git branch (including remote branches)
`fco`                     | Checkout Git branch/tag
`fcoc`                    | Checkout Git commit
`fcs`                     | Get Git commit SHA hash
`fd`                      | cd into selected directory
`fda`                     | cd into selected directory, including hidden directories
`fdr`                     | cd into selected parent directory
`fe [FUZZY PATTERN]`      | Open the selected file with the default editor
`fh`                      | Select line from history, repeat without editing
`fhe`                     | Select line from history, leave for editing
`fkill`                   | Select process to kill (alternatively, type `kill`˽<kbd>Tab</kbd>)
`fo`                      | Equivalent to `fe`, but opens it with `xdg-open` if you press <kbd>Ctrl+O</kbd>
`fs [FUZZY PATTERN]`      | Select tmux session
`fshow`                   | Git commit browser
`fstash`                  | Git stash management (<kbd>Enter</kbd> to show contents of the stash, <kbd>Ctrl+D</kbd> to show a diff of the stash against your current HEAD, <kbd>Ctrl+B</kbd> to check the stash out as a branch, for easier merging)
`fst`                     | cd into the directory from stack
`ftags`                   | Search ctags
`ftpane`                  | Switch pane
`fzf-gitlog-multi-widget` | Multi-selectable `git show`
`fzf-gitlog-widget`       | Git log browser
`v`                       | Open files in `~/.viminfo`
`zd`                      | 'fuzzy-finder' + 'cd' = 'zd', the super function of `fd`, `fda`, `fdr`, `fst`, `cdf`, `zz`
`zz`                      | Selectable cd to 'frecency' directory
`runcmd`                  | Utility function used to run the command in the shell
`writecmd`                | Utility function used to write the command in the shell

zsh cmdline      | description
---              | ---
<kbd>Alt-i</kbd> | Paste the selected entry from `locate` output into the command line


Installation
------------

### Install fzf-extras

**Arch Linux**

Install [aur/fzf-extras](https://aur.archlinux.org/packages/fzf-extras).

**Manual**

```sh
git clone https://github.com/atweiden/fzf-extras ~/.fzf-extras
```

### Source fzf-extras

**Arch Linux**

```sh
cat >> ~/.bashrc <<'EOF'
[[ -e "/etc/profile.d/fzf-extras.bash" ]] \
  && source /etc/profile.d/fzf-extras.bash
EOF
```

**Manual**

```sh
cat >> ~/.bashrc <<'EOF'
[[ -e "$HOME/.fzf-extras/fzf-extras.bash" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.bash"
EOF
```


Dependencies
------------

**Required**

- [bash](https://www.gnu.org/software/bash/)
- [fzf](https://github.com/junegunn/fzf)
- [tmux](https://github.com/tmux/tmux)

**Optional**

- [ctags](https://github.com/universal-ctags/ctags)
- [fasd](https://github.com/clvv/fasd)
- [git](https://git-scm.com/)
- [mlocate](https://pagure.io/mlocate)
- [xdg-utils](https://www.freedesktop.org/wiki/Software/xdg-utils/)
- [zsh](https://www.zsh.org/)


Sources
-------

- [fzf/wiki](https://github.com/junegunn/fzf/wiki)
- [junegunn/dotfiles](https://github.com/junegunn/dotfiles)


See Also
--------

- [DanielFGray/fzf-scripts](https://github.com/DanielFGray/fzf-scripts)


License
-------

[MIT](LICENSE)
