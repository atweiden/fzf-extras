fzf-extras
==========

Additional key bindings for fzf, primarily Bash.

bash cmdline         | description
---                  | ---
`cdf`                | cd into the directory of the selected file
`fbr`                | Checkout Git branch (including remote branches)
`fco`                | Checkout Git branch/tag
`fcoc`               | Checkout Git commit
`fcs`                | Get Git commit SHA hash
`fd`                 | cd into selected directory
`fda`                | cd into selected directory, including hidden directories
`fdr`                | cd into selected parent directory
`fe [FUZZY PATTERN]` | Open the selected file with the default editor
`fh`                 | Select line from history, repeat without editing
`fhe`                | Select line from history, leave for editing
`fkill`              | Select process to kill (alternatively, type `kill`˽<kbd>Tab</kbd>)
`fo`                 | Equivalent to `fe`, but opens it with `xdg-open` if you press <kbd>Ctrl+O</kbd>
`fs [FUZZY PATTERN]` | Select tmux session
`fshow`              | Git commit browser
`fstash`             | Git stash management (<kbd>Enter</kbd> to show contents of the stash, <kbd>Ctrl+D</kbd> to show a diff of the stash against your current HEAD, <kbd>Ctrl+B</kbd> to check the stash out as a branch, for easier merging)
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

See Also
--------

- [DanielFGray/fzf-scripts](https://github.com/DanielFGray/fzf-scripts)

License
-------

[MIT](LICENSE)
