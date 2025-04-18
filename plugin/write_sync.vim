scriptencoding utf-8

if exists('g:loaded_write_sync')
  finish
endif
let g:loaded_write_sync = v:true

" Example: [['~/.dotfiles/AutoHotkey.ahk', '/mnt/c/Users/you/Desktop/AutoHotkey.ahk']]
" @type {Array<Array<string>>}
let g:write_sync_lists = get(g:, 'write_sync_lists', [])

let g:write_sync_echo_success_on_write = get(g:, 'write_sync_echo_success_on_write', v:false)

" @see `:help autocmd_add`
" @typedef {Parameters<typeof autocmd_add>[0]} AutoCmd

" @param {Array<string>} files - List of file paths to read and write
" @returns {Array<AutoCmd>}
function! s:make_autocmds_to_write_files(files) abort
  const files = mapnew(a:files, { _i, file -> expand(file) })
  return mapnew(files, { _i, file ->
    \ s:make_autocmd_to_write_to_others(
      \ file,
      \ filter(copy(files), { _i, other_file -> other_file !=# file })
    \ )
  \ })
endfunction

" @param {string} source - A file path to be read content
" @param {Array<string>} other_files - List of file paths to be written with the `source` content
" @returns {AutoCmd}
function! s:make_autocmd_to_write_to_others(source, other_files) abort
  return #{
    \ group: 'VimWriteSync',
    \ event: 'BufWritePost',
    \ pattern: a:source,
    \ cmd: $'call write_sync#write_all("{a:source}", {a:other_files})',
  \ }
endfunction

" @template T
" @param {Array<T>} xs
" @param {(x: T) -> Array<T>} k
" @returns {Array<T>}
function! s:flatmap(xs, k) abort
  return a:xs->mapnew(a:k)->flatten(1)
endfunction

let _ = g:write_sync_lists
  \ ->s:flatmap({ _i, files ->
    \ s:make_autocmds_to_write_files(files)
  \ })
  \ ->autocmd_add()
