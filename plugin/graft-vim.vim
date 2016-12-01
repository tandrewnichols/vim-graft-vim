if exists('g:loaded_graft_vim') || &cp | finish | endif

call RegisterGraftLoader("vim", "vim")
