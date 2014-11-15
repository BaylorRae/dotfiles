function fish_prompt
  divider

  set_color -o green
  echo -n 'nedry1'

  set_color normal
  echo -n ':'(zsh -c "print -P %~")

  # has .git directory
  if test -d .git
    echo -n '('
    set_color blue

    # current branch
    echo -n (__fish_git_prompt "%s" | sed 's/ //')

    if git diff --quiet --cached 2>/dev/null; else
      set_color -o green
      echo -n '+'
    end

    set_color -o red

    if git_isworktreeclean; else
      echo -n '!'
    end

    if git_hasuntracked
      echo -n '?'
    end

    set_color normal
    echo -n ')'
  end
  
  set_color yellow
  echo -n ' 🍍  '

  set_color normal
end
