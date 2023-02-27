function rmorphans --wraps='pacman -R (pacman -Qdt)' --wraps='sudo pacman -R (pacman -Qdt)' --wraps='sudo pacman -R (pacman -Qqdt)' --description 'alias rmorphans sudo pacman -R (pacman -Qqdt)'
  sudo pacman -R (pacman -Qqdt) $argv; 
end
