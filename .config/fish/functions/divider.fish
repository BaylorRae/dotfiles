function divider
  set cols (math $COLUMNS - 1)

  set_color black
  zsh -c "repeat $cols printf '-'"
  set_color normal

  echo
end
