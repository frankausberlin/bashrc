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
    xterm-color|*-256color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
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
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# >>> my stuff >>>
#  .-"""-.
# / _   _ \
# ](_' `_)[
# `-. N ,-' 
#   |   |
#   `---'
# >>>>>>>>>>>>>>>>
# Do not execute the conda/mamba block in vscode or if a .venv exists: start if-block
if [ "$TERM_PROGRAM" != "vscode" ] && [ ! -d ./.venv ] && [ "$FORCE_MAMBA_INIT" != "true" ]; then
    deactivate 2>/dev/null || true # deactivate any existing .venv environment
# <<< my stuff <<<
#  .-"""-.
# / _   _ \
# ](_' `_)[
# `-. N ,-' 
#   |   |
#   `---'
# <<<<<<<<<<<<<<<<

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/frank/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/frank/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/home/frank/miniforge3/etc/profile.d/conda.sh"
        else
            export PATH="/home/frank/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba shell init' !!
    export MAMBA_EXE='/home/frank/miniforge3/bin/mamba';
    export MAMBA_ROOT_PREFIX='/home/frank/miniforge3';
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
    fi
    unset __mamba_setup
    # <<< mamba initialize <<<


# >>> my stuff >>>
#  .-"""-.
# / _   _ \
# ](_' `_)[
# `-. N ,-' 
#   |   |
#   `---'
# >>>>>>>>>>>>>>>>
else # Do not execute the conda/mamba block in vscode or if a .venv exists: end if-block
    # deactivate mamba/conda env if active twice env -> base; base -> none
    [[ -n "$CONDA_PREFIX" ]] && conda deactivate > /dev/null 2>&1
    [[ -n "$CONDA_PREFIX" ]] && conda deactivate > /dev/null 2>&1
    # load custom env file if it exists
    [ -d ./.venv ] && source .venv/bin/activate
fi

###################################################################
# function party
###################################################################
source ~/.bash_lib # exportadd, exportfolder, jl, adx, nxx, pyini

###################################################################
# export party
###################################################################
exportadd    "$HOME/Android/Sdk/platform-tools"
exportadd    "/usr/local/cuda/bin"
exportadd    "$HOME/go/bin"
exportadd    "$HOME/.local/bin"
exportadd    "$HOME/bin"
exportadd    "/usr/local/cuda/lib64" LD_LIBRARY_PATH
export       OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export       TIMEZONE=Europe/Berlin
export       N8N_SECURE_COOKIE=false
export       TF_CPP_MIN_LOG_LEVEL=2
exportfolder $HOME/.config/_exports

###################################################################
# alias party
###################################################################
source ~/.bash_aliases

###################################################################
# one-liner party
###################################################################
cw() { [[ "$1" == "." ]] && echo "$PWD" > "$HOME/.config/current_working_folder" || cd "$(cat "$HOME/.config/current_working_folder")"; }
deco() { [ "$#" -eq 0 ] && python -c "print('#'*80)"; [ "$#" -eq 1 ] && python -c "print('$1'*80)"; [ "$#" -eq 2 ] && python -c "print('$1'*$2)"; }
act() { [ "$#" -ne 0 ] && echo $1 > ~/.startenv && mamba activate $1; }
chrome() { [[ "$1" == "d" ]] && chromerdb || google-chrome; }
rlb() { [[ "$1" == "m" ]] && export FORCE_MAMBA_INIT="true" || export FORCE_MAMBA_INIT="false"; source ~/.bashrc; }


###################################################################
# behavior party
###################################################################
# deactivate any existing .venv environment if mamba init is forced
[[ $FORCE_MAMBA_INIT == "true" ]] && deactivate 2>/dev/null || true 
# activate last used python environment unless in vscode or a .venv exists or forced
[[ ( "$TERM_PROGRAM" != "vscode" && ! -d ./.venv ) || "$FORCE_MAMBA_INIT" == "true" ]] && mamba activate $([[ -f ~/.startenv ]] && cat ~/.startenv || echo base)

# remember last error in ~/.lasterror to use it in wtf-command 
trap 'if [ $? -ne 0 ]; then
  echo "Error at $(date): $BASH_COMMAND" > ~/.lasterror;
  echo "Error details:" >> ~/.lasterror;
  echo "$($BASH_COMMAND 2>&1)" >> ~/.lasterror;
  fi' ERR

# fzf keybindings and fuzzy completion (Debian package)
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
  . /usr/share/doc/fzf/examples/key-bindings.bash
fi

# My smart PS1: shows random emoji, user@host, current folder, python env info
prompt_user=$(whoami)
prompt_host=$(hostname)
PS1='$(RANDOM_EMOJI) \[\033[1;32m\]╭──(\[\033[1;34m\]${prompt_user}@${prompt_host}\[\033[1;32m\])─[\[\033[1;37m\]\w\[\033[1;32m\]] $(python_info)
\[\033[1;32m\]╰─\[\033[1;34m\]\$\[\033[0m\] '

# <<< my stuff <<<
#  .-"""-.
# / _   _ \
# ](_' `_)[
# `-. N ,-' 
#   |   |
#   `---'
# <<<<<<<<<<<<<<<<

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH


# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/frank/.cache/lm-studio/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


. "$HOME/.cargo/env"

export PATH=$PATH:/opt/android-ndk/android-ndk-r29/toolchains/llvm/prebuilt/linux-x86_64/bin
