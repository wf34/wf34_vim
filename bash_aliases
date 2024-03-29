###############################################################################
# ls
###############################################################################

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
alias l='ls -alF'
alias la='ls -A'
alias ll='ls -CF'

rinfo() {
  rosbag info "$@"
}

rinfoh() {
  rinfo "$@" | head
}

###############################################################################
# cmart_cd
###############################################################################

# cd up to n dirs
# using:  cd.. 10   cd.. dir
function cd_up() {
  case $1 in
    *[!0-9]*)                                          # if no a number
      cd $( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" )     # search dir_name in current path, if found - cd to it
      ;;                                               # if not found - not cd
    *)
      cd $(printf "%0.0s../" $(seq 1 $1));             # cd ../../../../  (N dirs)
    ;;
  esac
}
alias 'cd..'='cd_up'                                # can not name function 'cd..'
alias '..'='cd..'
alias '..2'='cd.. 2'
alias '..3'='cd.. 3'
alias '..4'='cd.. 4'
alias '..5'='cd.. 5'

###############################################################################
# persistent history 
###############################################################################
HISTTIMEFORMAT="%d/%m/%y %T "
log_bash_persistent_history()
{
  [[
      $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
        log_bash_persistent_history
}
export PROMPT_COMMAND="run_on_prompt_command"

alias phgrep='cat ~/.persistent_history|grep --color'
function phgrep10() { phgrep "${1}" | tail -n 10; }
alias hgrep='history|grep --color'
alias g='git'

# env vars
export VISUAL="vim"

# do not lock ctrl s in terminal
if [[ -t 0 && $- = *i* ]]
then
    stty -ixon
fi
