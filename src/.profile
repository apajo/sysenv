export SYSENV="/etc/sysenv"

source $SYSENV/sysenv.complete
alias sysenv="$SYSENV/sysenv";
export sysenv

alias yadm="sudo yadm -Y /etc/sysenv";
alias syadm="sudo yadm -Y /etc/sysenv";
export yadm
export syadm