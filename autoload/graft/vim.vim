function! graft#vim#load()
  let matched = {}
  let fnMessage = graft#vim#captureVerbose("function")
  if !empty(fnMessage)
    let matched.file = graft#vim#pluckFilename(fnMessage)
  endif

  if !has_key(matched, 'file') || empty(matched.file)
    let cmdMessage = graft#vim#captureVerbose("command")
    if !empty(cmdMessage)
      let matched.file = graft#vim#pluckFilename(cmdMessage)
    endif
  endif

  return matched
endfunction

function! graft#vim#captureVerbose(cmd)
  let curword = expand("<cword>")
  redir => message
  try
    silent! exec "silent verbose " . a:cmd . " " . curword
    redir END
  catch
    return "" 
  endtry

  return message
endfunction

function! graft#vim#pluckFilename(verboseOutput)
  let filename = matchlist(a:verboseOutput, "\\vLast set from ([^\\n]+)")
  if len(filename)
    return filename[1]
  endif

  return ''
endfunction
