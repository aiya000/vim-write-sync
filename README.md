# :sparkles: write-sync.vim :sparkles:

When you did `:w`, write an another file with the same file content.

![](./readme/logo.png)

For Vim/Neovim.

## How to work

**You want to write `/mnt/c/Users/you/Desktop/AutoHotkey.ahk` when `~/.dotfiles/AutoHotkey.ahk`

1. Confirmation

```shell-session
$ ls /mnt/c/Users/you/Desktop/AutoHotkey.ahk
ls: cannot access '/mnt/c/Users/you/Desktop/AutoHotkey.ahk': No such file or directory

# Or
$ cat /mnt/c/Users/you/Desktop/AutoHotkey.ahk
(an another content)
```

2. Edit original file

```shell-session
$ vim ~/.dotfiles/AutoHotkey.ahk
```

~/.dotfiles/AutoHotkey.ahk
```ahk
# You wrote some content.
# ...
```

3. Check the another file

```shell-session
$ cat /mnt/c/Users/you/Desktop/AutoHotkey.ahk
# You wrote some content.
# ...
```

Good.

## Doesn't work well

Please submit [issue](https://github.com/aiya000/vim-write-sync/issues/new) in a light hearted manner!
We welcome this!

- e.g., "Doesn't work on my Neovim", "Doesn't work on my Vim version XXX"
