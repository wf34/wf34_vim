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

###############################################################################
# autojump
###############################################################################
[[ -s /home/dmitri/.autojump/etc/profile.d/autojump.sh ]] && \
   source /home/dmitri/.autojump/etc/profile.d/autojump.sh

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

