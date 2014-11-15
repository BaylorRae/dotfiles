function fish_prompt
  divider

  set_color -o green
  echo -n 'nedry1'

  set_color normal
  echo -n ':'(zsh -c "print -P %~")
  
  set_color yellow
  echo -n ' 🍍  '

  set_color normal
end
