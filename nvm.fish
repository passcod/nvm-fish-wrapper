#? NVM wrapper. Félix Saparelli. Public Domain
#> https://github.com/passcod/nvm-fish-wrapper
#v 1.0.0

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
  set -l tmpdir (mktemp -d 2>/dev/null; or mktemp -d -t 'nvm-wrapper') # Linux || OS X
  set -l tmpfile $tmpdir/nenv

  set -l oldenv (env | grep -E '^(NVM_|PATH=)')

  env -i MANPATH=$MANPATH $oldenv bash -c "source ~/.nvm/nvm.sh && nvm $argv && env > $tmpfile"

  set -l nvmstat $status
  if test $nvmstat -gt 0
    return $nvmstat
  end

  for e in (cat $tmpfile)
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

  return $nvmstat
end
