function git_isworktreeclean
  if git diff --quiet 2>/dev/null
    return 0
  else
    return 1
  end
end
