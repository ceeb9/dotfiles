function ls --wraps='exa --icons -1lbh --no-permissions --no-user --no-time --group-directories-first' --description 'alias ls exa --icons -1lbh --no-permissions --no-user --no-time --group-directories-first'
  exa --icons -1lbh --no-permissions --no-user --no-time --group-directories-first $argv;
end
