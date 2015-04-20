fzf-extras
==========

Additional key bindings for fzf, primarily Bash.

bash cmdline         | description
---                  | ---
`cdf`                | cd into the directory of the selected file
`fbr`                | Checkout Git branch (including remote branches)
`fco`                | Checkout Git commit
`fd`                 | cd into selected directory
`fda`                | cd into selected directory, including hidden directories
`fe [FUZZY PATTERN]` | Open the selected file with the default editor
`fh`                 | Select line from history, repeat without editing
`fhe`                | Select line from history, leave for editing
`fkill`              | Select process to kill (alternatively, type `kill`˽<kbd>Tab</kbd>)
`fo`                 | Equivalent to `fe`, but opens it with `xdg-open` if you press <kbd>Ctrl+O</kbd>
`fs [FUZZY PATTERN]` | Select tmux session
`fshow`              | Git commit browser (<kbd>Enter</kbd> for show, <kbd>Ctrl+D</kbd> for diff, backtick <kbd>`</kbd> toggles sort)
`ftags`              | Search ctags
`ftpane`             | Switch pane
`v`                  | Open files in `~/.viminfo`
`writecmd`           | Utility function used to write the command in the shell


zsh cmdline      | description
---              | ---
<kbd>Alt-i</kbd> | Paste the selected entry from `locate` output into the command line


Sources
-------

- [fzf wiki](https://github.com/junegunn/fzf/wiki)
- [junegunn/dotfiles](https://github.com/junegunn/dotfiles)


License
-------

[MIT](LICENSE)
