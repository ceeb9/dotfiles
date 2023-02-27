function lsorphans --wraps='pacman -Qdt' --description 'alias lsorphans pacman -Qdt'
  pacman -Qdt $argv; 
end
