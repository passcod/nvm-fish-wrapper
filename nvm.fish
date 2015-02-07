function nvm_set
  echo set: $argv
  set -gx $argv
end

function nvm_split_env
  set k (echo $argv | cut -d\= -f1)
  set v (echo $argv | cut -d\= -f2-)
  echo "$k" "$v"
end

function nvm_split_path
  echo $argv | grep -oE '[^:]+'
end

function nvm
  set nenv (env -i bash -c "source ~/.nvm/nvm.sh && nvm $argv 2>&1 >/dev/null; env")
  for e in $nenv
    set k (echo $e | cut -d\= -f1)

    if test (echo $e | cut -d_ -f1) = NVM
      set v (echo $e | cut -d\= -f2-)
      nvm_set $k $v
    else if test (echo $e | cut -d\= -f1) = PATH
      set o (echo $e | cut -d\= -f2-)
      set p (echo $o | grep -oE '[^:]+' | grep -w '.nvm' | head -n1)
      set v $p $PATH
      nvm_set $k $v
    else if test (echo $e | cut -d\= -f1) = MANPATH
      set o (echo $e | cut -d\= -f2-)
      set p (echo $o | grep -oE '[^:]+' | grep -w '.nvm' | head -n1)
      set v $p $MANPATH
      nvm_set $k $v
    end
  end
end
