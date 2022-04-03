#!/bin/bash

envfile=$HOME"/.config/.sysenv";

home=$1;
home=${home:-$HOME};
home=${home:-$SYSENV_HOME};

repo=$2;
repo=${repo:-$SYSENV_REPO};

branch=$3
user=$(whoami)

if [ $(whoami) == "root" ]; then
  user=$(hostname)
fi

branch=${branch:-$user};
branch=${branch:-$SYSENV_BRANCH};

sysenv_save () {
  sysenv_config_save "SYSENV_HOME"    ${params[0]};
  sysenv_config_save "SYSENV_REPO"    ${params[1]};
  sysenv_config_save "SYSENV_BRANCH"  ${params[2]};
}


returncode=0
while test $returncode != 1 && test $returncode != 250
do
  ##--output-separator " " \
  exec 3>&1
    returntext=`$DIALOG --ok-label "Submit" \
        --backtitle "$app_name $app_version" \
        --form "Setup your system repository and default branch etc" \
          10 60 0 \
            "Home directory:"         1 1	"$home"     1 20 40 50 \
            "Repository:"         2 1	"$repo"     2 20 40 50 \
            "User/device:"      3 1	"$branch"   3 20 40 20 \
          2>&1 1>&3`
    returncode=$?
  exec 3>&-

show=`echo "$returntext" | sed -e 's/^/	/'`

	case $returncode in
	$DIALOG_CANCEL)
		route_back
		;;
	$DIALOG_OK)
	    IFS=$'\n'
	    params=($returntext)
	    #sysenv_save $params;
	    dialog_error "tere"

      route_back
		;;

	*)
		exit
		;;
	esac
done
