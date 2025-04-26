" @see `write_sync#write_all()`
let s:suppress_rewrite = v:false

function! s:echomsg_error(message) abort
  echohl ErrorMsg
  echomsg a:message
  echohl None
endfunction

function! s:get_echo_method(maybe_method) abort
  return
    \ a:maybe_method ==# v:null || a:maybe_method ==# 'echo'
    \ ? 'echo'
    \ : a:maybe_method ==# 'echomsg'
      \ ? 'echomsg'
      \ : execute($'throw "Unknown echo method: {a:maybe_method}"')
endfunction

function! s:echo_if_enabled(message, ...) abort
  if g:write_sync_echo_success_on_write
    const echo = s:get_echo_method(get(a:000, 0, v:null))
    execute echo $'"{a:message}"'
  endif
endfunction

" @param {string} source
" @param {Array<string>} target_files - Same as `other_files` in `s:make_autocmd_to_write_to_others()`
" @returns {void}
function! write_sync#write_all(source, target_files) abort
  let s:suppress_rewrite = v:true
  let written_files = []

  try
    const content = readfile(a:source)
    for file in a:target_files
      if !filewritable(file)
        call s:echo_if_enabled($'Not a writable file (skipped): {file}', 'echomsg')
        continue
      endif
      call writefile(content, file)
      call add(written_files, file)
    endfor
    bufdo call s:reload_buffers(written_files)
  catch
    call s:echomsg_error($'Error writing to files: {a:target_files}')
    call s:echomsg_error(v:exception)
  finally
    call s:echo_if_enabled($'Wrote to {written_files->join(', ')}')
    let s:suppress_rewrite = v:false
  endtry
endfunction

" @param {Array<string>} written_files
function! s:reload_buffers(written_files) abort
  for file in a:written_files
    execute ':silent' 'edit' file
  endfor
endfunction
