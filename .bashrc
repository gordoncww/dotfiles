# Add paths that should have been there by default
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="~/bin:$PATH"

# Erase duplicates in history
#   Other possible values:
#   ignoredups   ignores consecutive dups
#   ignorespace  ignores commands staring with space
#   ignoreboth   ignoredups & ignorespace
export HISTCONTROL=erasedups
# Store 100k history entries
export HISTSIZE=100000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

# Source bashrc commands local to this machine.
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

eval "$(rbenv init -)"
