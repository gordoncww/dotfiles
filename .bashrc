# Add paths that should have been there by default
export PATH=${PATH}:/usr/local/bin
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
