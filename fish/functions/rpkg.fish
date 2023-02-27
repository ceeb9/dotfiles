function rpkg --wraps='paru -Rsnh' --description 'alias rpkg paru -Rsnh'
  paru -Rsnh $argv; 
end
