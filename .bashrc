# Add paths that should have been there by default
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="~/bin:$PATH"

# Erase duplicates in history
#   Other possible values:
#   ignoredups   ignores consecutive dups
#   ignorespace  ignores commands staring with space
#   ignoreboth   ignoredups & ignorespace
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

# Source bashrc commands local to this machine.
source ~/.bashrc.local

# Load RVM into a shell session
[[ -s "/Users/gordon/.rvm/scripts/rvm" ]] && source "/Users/gordon/.rvm/scripts/rvm"
# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
