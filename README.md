# :sparkles: write-sync.vim :sparkles:

When you did `:w` (`:write`), write an another file with the same file content.

![](./readme/logo.png)

For Vim/Neovim.

## Installation

- Example for [dein.vim](https://github.com/Shougo/dein.vim).
    - See [dein#add()](https://github.com/Shougo/dein.vim/blob/master/doc/dein.txt#L114)

~/.vimrc
```vim
call dein#begin(s:dein_base)
" ...
call dein#add('aiya000/vim-write-sync')
" ...
call dein#end()
```

Then, do `call dein#install()`.

## How to work

If you want to write `~/.dotfiles/AutoHotkey.ahk` when `/mnt/c/Users/you/Desktop/AutoHotkey.ahk`:

1. Configure your .vimrc

```vim
" Also paths like '~/' are available.
" These are expanded by `expand()`
let g:write_sync_lists = [
  \ [
    \ '~/.dotfiles/AutoHotkey.ahk',
    \ '/mnt/c/Users/you/Desktop/AutoHotkey.ahk',
  \ ]
\ ]
```

2. Confirmation

```shell-session
$ ls /mnt/c/Users/you/Desktop/AutoHotkey.ahk
ls: cannot access '/mnt/c/Users/you/Desktop/AutoHotkey.ahk': No such file or directory

# Or

$ cat /mnt/c/Users/you/Desktop/AutoHotkey.ahk
(an another content)
```

3. Edit original file

```shell-session
$ vim ~/.dotfiles/AutoHotkey.ahk
```

~/.dotfiles/AutoHotkey.ahk
```ahk
# You wrote some content.
# ...
```

4. Check the another file

```shell-session
$ cat /mnt/c/Users/you/Desktop/AutoHotkey.ahk
# You wrote some content.
# ...
```

Good.

## Other options

```vim
" Notify result by `:echo` when file synchronization (simultaneous writes) is finished (default: v:false)
let g:write_sync_echo_success_on_write = v:true
```

## Doesn't work well

Please submit [issue](https://github.com/aiya000/vim-write-sync/issues/new) in a light hearted manner!
We welcome this!

- e.g., "Doesn't work on my Neovim", "Doesn't work on my Vim version XXX"
