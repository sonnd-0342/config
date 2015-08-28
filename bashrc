# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# ngo.duy.son----------------------------------------------------------
# Load .bash_aliases
if [ -f ~/.bash/bash_aliases ]; then
  . ~/.bash/bash_aliases
fi

# Load in the git branch prompt script.
source ~/.bash/git-prompt.sh
bash_prompt() {
  case $TERM in
    xterm*|rxvt*)
      local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
      ;;
    *)
      local TITLEBAR=""
      ;;
  esac
  local NONE="\[\033[0m\]"  # unsets color to term's fg color

  # regular colors
  local K="\[\033[0;30m\]"  # black
  local R="\[\033[0;31m\]"  # red
  local G="\[\033[0;32m\]"  # green
  local Y="\[\033[0;33m\]"  # yellow
  local B="\[\033[0;34m\]"  # blue
  local M="\[\033[0;35m\]"  # magenta
  local C="\[\033[0;36m\]"  # cyan
  local W="\[\033[0;37m\]"  # white

  # emphasized (bolded) colors
  local EMK="\[\033[1;30m\]"
  local EMR="\[\033[1;31m\]"
  local EMG="\[\033[1;32m\]"
  local EMY="\[\033[1;33m\]"
  local EMB="\[\033[1;34m\]"
  local EMM="\[\033[1;35m\]"
  local EMC="\[\033[1;36m\]"
  local EMW="\[\033[1;37m\]"

  # background colors
  local BGK="\[\033[40m\]"
  local BGR="\[\033[41m\]"
  local BGG="\[\033[42m\]"
  local BGY="\[\033[43m\]"
  local BGB="\[\033[44m\]"
  local BGM="\[\033[45m\]"
  local BGC="\[\033[46m\]"
  local BGW="\[\033[47m\]"

  local UC=$EMY     # user's color
  [ $UID -eq "0" ] && UC=$EMR # root's color

  # PS1="$TITLEBAR ${EMK}[${UC}\u${EMK}@${UC}\h ${EMB}\${NEW_PWD}${EMK}]${UC}\\$ ${NONE}"
  # PS1="\[$GREEN\]\t\[$RED\]-\[$BLUE\]\u\[$YELLOW\]\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]\$(__git_ps1)\[$WHITE\]\$ "
  # PS1="$TITLEBAR\[$R\][\[$C\]\t\[$R\]]\[$UC\]\u\[$Y\]\[$R\]\w\[\033[m\]\[$EMW\]\$(__git_ps1)\[$EMG\]\\$ "
  PS1="$TITLEBAR${C}[${G}\t${C}]${Y}\w\[\033[m\]${EMB}\$(__git_ps1)${EMG}\\$ "
  # PS1="$TITLEBAR${R}[${C}\t${R}]${UC}\u${Y}${W}\w\[\033[m\]${EMB}\$(__git_ps1)${EMG}\\$ "
  # PS1="$TITLEBAR${R}${UC}\u${Y}${W}\w\[\033[m\]${EMY}\$(__git_ps1)${EMW}\\$ "
  # PS1="$TITLEBAR${R}${UC}\u${Y}${W}\w\[\033[m\]${EMB}${EMG}\\$ "
  # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
  # PS1="[\u@\h \${NEW_PWD}]\\$ "
  # extra backslash in front of \$ to make bash colorize the prompt
}

bash_prompt
unset bash_prompt

# Color scheme for grep and ls
export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced
LS_COLORS='di=32:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'

# Enable Laravel command line
export PATH=~/.composer/vendor/bin:$PATH
