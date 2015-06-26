#? NVM wrapper. Félix Saparelli. Public Domain
#> https://github.com/passcod/nvm-fish-wrapper
#v 1.2.2

function nvm_set
  if test (count $argv) -gt 1
    #echo set: k: $argv[1] v: $argv[2..-1]
    set -gx $argv[1] $argv[2..-1]
  else
    #echo unset: k: $argv[1]
    set -egx $argv[1]
  end
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
    if echo $o | grep -qvw '.nvm'
      set newpath $newpath $o
    end
  end

  set p (nvm_find_paths $r | head -n1)
  set newpath $p $newpath
  nvm_set $k $newpath
end

function nvm_mod_env
  set tmpnew $tmpdir/newenv

  bash -c "source ~/.nvm/nvm.sh && source $tmpold && nvm $argv && export status=\$? && env > $tmpnew && exit \$status"

  set nvmstat $status
  if test $nvmstat -gt 0
    return $nvmstat
  end

  for e in (cat $tmpnew)
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
      set -l t (echo $p[2..-1] | cut -sd\: -f2-)
      if test '' = "$t"
        # We're assuming that if there's only one path
        # in the MANPATH, we should append the default
        # value. That may be wrong in some edge-cases.
        set -l m $p[2..-1]:(manpath -g)
        nvm_set MANPATH $m
      else
        nvm_set MANPATH $p[2..-1]
      end
    end
  end

  return $nvmstat
end

function nvm
  set -g tmpdir (mktemp -d 2>/dev/null; or mktemp -d -t 'nvm-wrapper') # Linux || OS X
  set -g tmpold $tmpdir/oldenv
  env | grep -E '^((NVM|NODE)_|(MAN)?PATH=)' > $tmpold

  set -l arg1 $argv[1]
  if echo $arg1 | grep -qE '^(use|install|deactivate)$'
    nvm_mod_env $argv
    set s $status
  else if test $arg1 = 'unload'
    functions -e (functions | grep -E '^nvm(_|$)')
  else
    bash -c "source ~/.nvm/nvm.sh && source $tmpold && nvm $argv"
    set s $status
  end

  command rm -r $tmpdir
  return $s
end
