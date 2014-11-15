function git_isindexclean
  if git diff --quiet --cached 2>/dev/null
    return 0
  else
    return 1
  end
end
