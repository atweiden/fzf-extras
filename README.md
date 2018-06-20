fzf-extras
==========

Additional key bindings for fzf, primarily Bash.

Usage
-----

**directory**

bash cmdline              | description
---                       | ---
`zd`                      | 'fuzzy-finder' + 'cd' = 'zd', the super function of `_fd`, `_fda`, `_fdr`, `_fst`, `_cdf`, `_zz`
`_cdf`                    | cd into the directory of the selected file
`_fd`                     | cd into selected directory
`_fda`                    | cd into selected directory, including hidden directories
`_fdr`                    | cd into selected parent directory
`_fst`                    | cd into the directory from stack
`_zz`                     | Selectable cd to 'frecency' directory

**file**

bash cmdline              | description
---                       | ---
`e`                       | Open 'frecency' files with `$VISUAL` editor
`fe [FUZZY PATTERN]`      | Open selected file with `$EDITOR`
`fo`                      | Equivalent to `fe`, but opens file with `$OPENER` (default: `xdg-open`) if you press <kbd>Ctrl+O</kbd>
`v`                       | Open selected files from `~/.viminfo` with `$EDITOR`

**git**

bash cmdline              | description
---                       | ---
`fbr`                     | Checkout Git branch (including remote branches)
`fco`                     | Checkout Git branch/tag
`fcoc`                    | Checkout Git commit
`fcs`                     | Get Git commit SHA hash
`fshow`                   | Git commit browser
`fstash`                  | Git stash management (<kbd>Enter</kbd> to show contents of the stash, <kbd>Ctrl+D</kbd> to show a diff of the stash against your current HEAD, <kbd>Ctrl+B</kbd> to check the stash out as a branch, for easier merging)
`fzf-gitlog-multi-widget` | Multi-selectable `git show`
`fzf-gitlog-widget`       | Git log browser

**history**

bash cmdline              | description
---                       | ---
`fh`                      | Select line from history, repeat without editing
`fhe`                     | Select line from history, leave for editing
`runcmd`                  | Utility function used to run the command in the shell
`writecmd`                | Utility function used to write the command in the shell

**pid**

bash cmdline              | description
---                       | ---
`fkill`                   | Select process to kill (alternatively, type `kill`˽<kbd>Tab</kbd>)

**tags**

bash cmdline              | description
---                       | ---
`ftags`                   | Search ctags

**tmux**

bash cmdline              | description
---                       | ---
`fs [FUZZY PATTERN]`      | Select tmux session
`ftpane`                  | Switch pane

**zsh**

zsh cmdline               | description
---                       | ---
<kbd>Alt-i</kbd>          | Paste the selected entry from `locate` output into the command line


Installation
------------

### Install fzf-extras

**Arch Linux**

Install [aur/fzf-extras](https://aur.archlinux.org/packages/fzf-extras).

**Manual**

```sh
git clone https://github.com/atweiden/fzf-extras ~/.fzf-extras
```

### Configure fzf-extras

To make use of function `fo`, consider setting the `$OPENER` environment
variable. If `$OPENER` is unset, `fo` will attempt to open files with
`xdg-open` when pressing <kbd>Ctrl+O</kbd>.

**Arch Linux**

```sh
cat >> ~/.bashrc <<'EOF'
OPENER=mimeo
EOF
```

**MacOS**

```sh
cat >> ~/.bashrc <<'EOF'
OPENER=open
EOF
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
- [vim](https://www.vim.org/)
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
