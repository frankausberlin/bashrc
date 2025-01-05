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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

if [ -f "/home/frank/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/frank/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# >>> my stuff >>>
#  .-"""-.
# / _   _ \
# ](_' `_)[
# `-. N ,-' 
#   |   |
#   `---'
# >>>>>>>>>>>>>>>>

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH=/home/frank/Android/Sdk/platform-tools:/home/frank/bin:$PATH
alias suu="sudo apt update && sudo apt upgrade -y && flatpak update -y"
alias los="sudo apt update && sudo apt upgrade -y && flatpak update -y && jl"
alias rtc='npm start --prefix ~/labor/gits/openai-realtime-console'
alias comfy='act ds; python ~/labor/gits/ComfyUI/main.py'
alias a11='mamba activate a11; ~/labor/gits/stable-diffusion-webui/webui.sh; mamba activate $(test -f ~/.startenv && cat ~/.startenv || echo base)'
alias hä='sgpt -d "es folgt die fehlerausgabe eines bash kommandos. bitte erkläre was die fehlermeldung bedeutet und wie man sie behoben werden kann. hier kommt die meldung: $(cat ~/.lasterror)"'
alias l='cd ~/labor'
alias g='cd ~/labor/gits'
alias d='cd ~/Downloads'
alias ex='sgpt -s'
alias cursor='~/apps/cursor/cursor-0.44.9-build-2412268nc6pfzgo-x86_64.AppImage --no-sandbox'
# opencv cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH


# make alias function n for nnn: cd on quit # test git
n () {
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -H "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}


# make env-vars
#if [ -x "$(command -v tokread)" ]; then tokread; fi
if [ -d "$HOME/.config/_exports" ]; then
  # Loop through all files in the directory
  count=-1
  for file in "$HOME/.config/_exports"/*; do
    ((count++)); ((count % 4 == 0)) && echo -n $'\n'
    # Check if it's a regular file
    if [ -f "$file" ]; then
      # Extract the filename without the path
      var_name=$(basename "$file")
      # Read the file content
      var_value=$(cat "$file")
      # Export the variable
      export "$var_name"="$var_value"
      # Print a message (optional)
      printf "%-35s " "$var_name"
    fi
  done
  printf '\n%*s\n' 147 '' | tr ' ' '_'
fi

# remember last error in ~/.lasterror to use it in hä-command 
trap 'if [ $? -ne 0 ]; then
  echo "Fehler am $(date): $BASH_COMMAND" > ~/.lasterror;
  echo "Fehlerdetails:" >> ~/.lasterror;
  echo "$($BASH_COMMAND 2>&1)" >> ~/.lasterror;
  fi' ERR


# <<< my stuff <<<

#>>>>>_insert_datasciencenotebook_>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# alternative mamba activate with remember last used environment
act() { [ "$#" -ne 0 ] && echo $1 > ~/.startenv && mamba activate $1; }

# activate last used environment
mamba activate $(test -f ~/.startenv && cat ~/.startenv || echo base)

# jupyter lab launcher
jl ()
{
    [ $# -eq 0 ] && __notebookdir='~/labor' || __notebookdir=$1
    echo '!!!ATENTION!!! every one in your network can access your local folder'
    echo 'use http://localhost:8888/ to conncect local runtime'
    echo "set notebook-dir to $__notebookdir"
    jupyter lab \
        --notebook-dir="$__notebookdir" \
        --NotebookApp.allow_origin='https://colab.research.google.com' \
        --port=8888 --NotebookApp.port_retries=0 \
        --allow-root \
        --NotebookApp.token='' \
        --NotebookApp.disable_check_xsrf=True
}
#<<<<<_end_insert_datasciencenotebook_<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

#>>>>>_insert_datasciencenotebook_>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
deco() { [ "$#" -eq 0 ] && python -c "print('#'*80)"; [ "$#" -eq 1 ] && python -c "print('$1'*80)"; [ "$#" -eq 2 ] && python -c "print('$1'*$2)"; }
alias ml="docker run --gpus all --rm -d -p 8080:8080 mltooling/ml-workspace-gpu; deco \# 64; echo -e '# ml-container runnig - launch \e[4;34mhttp://localhost:8080\e[0m or ssh ml #'; deco \# 64"
alias stop="docker stop \$(docker ps -q)"
#<<<<<_end_insert_datasciencenotebook_<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#>>>>>_insert_environmentnotebook_>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
###################################################################################################
# adx : show connections                # adx nr l - list packages of 192.168.178.nr              #
# adx nr - connect to <your_ip>.nr      # adx str - list grepfiltered packages (1 connectd)       #
# adx x - disconnect all                # adx nr str - list grepfiltered packages of <your_ip>.nr #
# adx l - list packages (1 connected)   #                                                         #
###################################################################################################
adx () {
    if [ "$#" -eq 0 ]; then
        adb devices
    else
        if [ "$1" = 'x' ]; then
            adb disconnect
        else
            if [ "$1" = 'l' ]; then
                if [ "$#" -eq 1 ]; then
                    adb shell pm list packages
                else
                    adb -s "192.168.178.$2" shell pm list packages
                fi
            else
                if [[ "$1" =~ ^[0-9]+$ ]]; then
                    if [ "$#" -eq 1 ]; then
                        adb connect 192.168.178.$1
                    else
                        adb -s "192.168.178.$1" shell pm list packages | grep -i "$2"
                    fi
                else
                    adb shell pm list packages | grep -i "$1"
                fi
            fi
        fi
    fi
}
#<<<<<_end_insert_environmentnotebook_<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

. "$HOME/.local/bin/env"


# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/frank/.cache/lm-studio/bin"
