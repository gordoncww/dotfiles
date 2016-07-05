# Add paths that should have been there by default
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="/usr/local/heroku/bin:$PATH" ## Added by the Heroku Toolbelt
export PATH="~/bin:$PATH"

# Load custom prompt
[[ -r ~/.bash_prompt ]] && [[ -f ~/.bash_prompt ]] && source ~/.bash_prompt

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

# Source bashrc commands local to this machine. Load this close to last so that one can change the above.
[[ -r ~/.bashrc.local ]] && [[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# If we've got it, initialitze rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
