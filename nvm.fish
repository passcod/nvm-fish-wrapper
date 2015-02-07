function nvm
  set nenv (env -i bash -c "source ~/.nvm/nvm.sh && nvm $argv 2>&1 >/dev/null; env")
  for e in $nenv
    if test (echo $e | cut -d_ -f1) = NVM
      set k (echo $e | cut -d\= -f1)
      set v (echo $e | cut -d\= -f2-)
      set -gx $k "$v"
    else if test (echo $e | cut -d\= -f1) = PATH
      set v (echo $e | cut -d\= -f2-)
      set p (echo $v | grep -oE '[^:]+' | grep -w '.nvm' | head -n1)
      set -gx $k "$v"
    else if test (echo $e | cut -d\= -f1) = MANPATH
      set v (echo $e | cut -d\= -f2-)
      set p (echo $v | grep -oE '[^:]+' | grep -w '.nvm' | head -n1)
      set -gx $k "$v"
    end
  end
end
