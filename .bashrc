# Determine OS
# Based on http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script#answer-3792848
lowercase() {
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

OS=`lowercase \`uname\``
KERNEL=`uname -r`
MACH=`uname -m`

if [ "${OS}" == "windowsnt" ]; then
  OS=Windows
elif [ "${OS}" == "darwin" ]; then
  OS=Mac
else
  OS=`uname`
  if [ "${OS}" = "SunOS" ] ; then
    OS=Solaris
    ARCH=`uname -p`
    OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
  elif [ "${OS}" = "AIX" ] ; then
    OSSTR="${OS} `oslevel` (`oslevel -r`)"
  elif [ "${OS}" = "Linux" ] ; then
    if [ -f /etc/redhat-release ] ; then
      DistroBasedOn='RedHat'
      DIST=`cat /etc/redhat-release |sed s/\ release.*//`
      PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
      REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/SuSE-release ] ; then
      DistroBasedOn='SuSe'
      PSUEDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
      REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
    elif [ -f /etc/mandrake-release ] ; then
      DistroBasedOn='Mandrake'
      PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
      REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/debian_version ] ; then
      DistroBasedOn='Debian'
      DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
      PSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
      REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
    fi
    if [ -f /etc/UnitedLinux-release ] ; then
      DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
    fi
    OS=`lowercase $OS`
    DistroBasedOn=`lowercase $DistroBasedOn`
    readonly OS
    readonly DIST
    readonly DistroBasedOn
    readonly PSUEDONAME
    readonly REV
    readonly KERNEL
    readonly MACH
  fi
fi

# Add paths that should have been there by default
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="~/bin:$PATH"

# Load functions
for function in "$(pwd)/.functions/*"; do
  source $function
done

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


# Git completion for os x and linux
GIT_VERSION="$(git --version | awk '{print $3}')"
if [ "$OS" = "Mac" ]; then
  GIT_COMPLETION_PATH="/usr/local/Cellar/git/$GIT_VERSION/etc/bash_completion.d/git-completion.bash"
elif [ "$OS" = "Linux" ]; then
  GIT_COMPLETION_PATH=/etc/bash_completion.d/git
fi
if [ -f $GIT_COMPLETION_PATH ]; then
  . $GIT_COMPLETION_PATH
fi

# Git prompt
do_version_check "$GIT_VERSION" '1.8'
if [ $? = '11' ]; then
  if [ "$OS" = "Mac" ]; then
    # As of git 1.8 the git prompt is in its own file
    GIT_PROMPT_PATH="/usr/local/Cellar/git/$GIT_VERSION/etc/bash_completion.d/git-prompt.sh"
  fi
  if [ -f $GIT_PROMPT_PATH ]; then
    . $GIT_PROMPT_PATH
  fi
fi
# TODO no need for these if we haven't loaded git prompt
GIT_PS1_SHOWDIRTYSTATE=true # */+ for dirty
GIT_PS1_SHOWSTASHSTATE=true # $ for stashes
GIT_PS1_SHOWUNTRACKEDFILES=true # % for untracked

export PS1="\e[0;33m\w\e[0;91m\$(__git_ps1 ' (%s)')\e[0;96m \$\e[0m "

# Source bashrc commands local to this machine.
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

eval "$(rbenv init -)"
