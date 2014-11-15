function cd -d "Change directory to new path or replace directory in existing path with two arguments"
  if test (count $argv) -eq 2
    builtin cd (pwd | awk -v SEARCH="$argv[1]" -v REPLACEMENT="$argv[2]" "{ sub(SEARCH, REPLACEMENT) ; print }")
  else
    builtin cd $argv
  end
end
