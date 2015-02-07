function nvm_set
  #echo set: k: $argv[1] v: $argv[2..-1]
  set -gx $argv[1] $argv[2..-1]
end

function nvm_split_env
  set k (echo $argv | cut -d\= -f1)
  set v (echo $argv | cut -d\= -f2-)
  echo $k
  echo $v
end

function nvm_find_paths
  echo $argv | grep -oE '[^:]+' | grep -w '.nvm'
end

function nvm_set_path
  set k $argv[1]
  set r $argv[2..-1]

  set newpath
  for o in $$k
    if echo $o | grep -qw '.nvm'
    else
      set newpath $newpath $o
    end
  end

  set p (nvm_find_paths $r | head -n1)
  set newpath $p $newpath
  nvm_set $k $newpath
end

function nvm
  # Todo: recover output
  set nenv (env -i MANPATH=$MANPATH bash -c "source ~/.nvm/nvm.sh && nvm $argv 2>&1 >/dev/null; env")
  for e in $nenv
    set p (nvm_split_env $e)
    
    if test (echo $p[1] | cut -d_ -f1) = NVM
      if test (count $p) -lt 2
        nvm_set $p[1] ''
        continue
      end

      nvm_set $p[1] $p[2..-1]
      continue
    end
    
    if test $p[1] = PATH
      nvm_set_path PATH $p[2..-1]
    else if test $p[1] = MANPATH
      nvm_set_path MANPATH $p[2..-1]
    end
  end
end
