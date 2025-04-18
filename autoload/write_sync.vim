" @see `write_sync#write_all()`
let s:suppress_rewrite = v:false

" @param {string} source
" @param {Array<string>} target_files - Same as `other_files` in `s:make_autocmd_to_write_to_others()`
" @returns {void}
function! write_sync#write_all(source, target_files) abort
  let s:suppress_rewrite = v:true
  let written_files = []

  try
    const content = readfile(a:source)
    for file in a:target_files
      call writefile(content, file)
      call add(written_files, file)
    endfor
    bufdo call s:reload_buffers(written_files)
  catch
    echohl ErrorMsg
    echomsg $'Error writing to files: {a:target_files}'
    echomsg v:exception
    echohl None
  finally
    if g:write_sync_echo_success_on_write
      echo $'Wrote to {written_files->join(', ')}'
    endif
    let s:suppress_rewrite = v:false
  endtry
endfunction

" @param {Array<string>} written_files
function! s:reload_buffers(written_files) abort
  for file in a:written_files
    execute ':edit' file
  endfor
endfunction
