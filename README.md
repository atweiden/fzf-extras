# fzf-extras

Additional key bindings for fzf, primarily Bash.

## Usage

### Bash

**directory**

bash cmdline              | description
---                       | ---
`zd`                      | 'fuzzy-finder' + 'cd' = 'zd', the super function of `zdd`, `zda`, `zdr`, `zdf`, `zst`, `zz`
`zdd`                     | cd into selected directory
`zda`                     | cd into selected directory, including hidden directories
`zdr`                     | cd into selected parent directory
`zdf`                     | cd into directory of selected file
`zst`                     | cd into directory from stack
`zz`                      | cd into selectable 'frecency' directory

**file**

bash cmdline              | description
---                       | ---
`e [FUZZY PATTERN]`       | Open 'frecency' files with `$EDITOR` editor
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
`fstash`                  | Git stash management (<kbd>Enter</kbd> to show stash contents, <kbd>Ctrl+D</kbd> to show diff of stash against current HEAD, <kbd>Ctrl+B</kbd> to check stash out as a branch, for easier merging)
`fzf-gitlog-multi-widget` | Multi-selectable `git show`
`fzf-gitlog-widget`       | Git log browser

**history**

bash cmdline              | description
---                       | ---
`fh`                      | Select line from history, repeat without editing
`fhe`                     | Select line from history, leave for editing
`runcmd`                  | Utility function used to run shell command
`writecmd`                | Utility function used to write shell command

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

### Zsh

**file**

zsh cmdline               | description
---                       | ---
<kbd>Alt-i</kbd>          | Paste selected entry from `locate` output into command line

## Installation

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

**macOS**

```sh
cat >> ~/.bashrc <<'EOF'
OPENER=open
EOF
```

### Source fzf-extras

**Arch Linux**

```sh
# bash users only
cat >> ~/.bashrc <<'EOF'
[[ -e "/usr/share/fzf/fzf-extras.bash" ]] \
  && source /usr/share/fzf/fzf-extras.bash
EOF

# zsh users only
cat >> ~/.zshrc <<'EOF'
[[ -e "/usr/share/fzf/fzf-extras.zsh" ]] \
  && source /usr/share/fzf/fzf-extras.zsh
EOF
```

**Manual**

```sh
# bash users only
cat >> ~/.bashrc <<'EOF'
[[ -e "$HOME/.fzf-extras/fzf-extras.sh" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.sh"
EOF

# zsh users only
cat >> ~/.zshrc <<'EOF'
[[ -e "$HOME/.fzf-extras/fzf-extras.zsh" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.zsh"
EOF
```

Zsh users should not be sourcing `fzf-extras.sh`.

The lack of meaningful support for Zsh will be fixed pending suitable
PRs from Zsh-using contributors. Note it is perfectly acceptable
to duplicate code from `fzf-extras.sh` into `fzf-extras.zsh`. See:
https://github.com/atweiden/fzf-extras/issues/12.

## Dependencies

**Required**

- [bash](https://www.gnu.org/software/bash/) or [zsh](https://www.zsh.org/)
- [fzf](https://github.com/junegunn/fzf)
- [tmux](https://github.com/tmux/tmux)

**Optional**

- [ctags](https://github.com/universal-ctags/ctags)
- [fasd](https://github.com/clvv/fasd)
- [git](https://git-scm.com/)
- [mlocate](https://pagure.io/mlocate)
- [vim](https://www.vim.org/)
- [xdg-utils](https://www.freedesktop.org/wiki/Software/xdg-utils/)

## Sources

- [fzf/wiki](https://github.com/junegunn/fzf/wiki)
- [junegunn/dotfiles](https://github.com/junegunn/dotfiles)

## See Also

- [DanielFGray/fzf-scripts](https://github.com/DanielFGray/fzf-scripts)

## License

[MIT](LICENSE)
