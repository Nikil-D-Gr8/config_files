# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# Add the below in .bashrc

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

eval "$(starship init bash)"

alias cat='batcat'
alias la='ls -a'
alias ll='ls -alF'
alias code="codium"
alias open="xdg-open"
alias vim='nvim'

fastfetch

cdls() {
  cd "$@" && la
}

inc() {
  local container=$1
  local dir=${2:-/mnt/debusine}

  if incus list --format csv -c ns | grep -q "^$container,RUNNING$"; then
    incus exec -t "$container" -- sudo -iu debian bash -lc "cd $dir && exec bash"
  else
    incus start "$container"
    incus exec -t "$container" -- sudo -iu debian bash -lc "cd $dir && exec bash"
  fi
}
