function git_hasuntracked
  if test (count (git ls-files --others --exclude-standard)) -gt 0
    return 0
  else
    return 1
  end
end
