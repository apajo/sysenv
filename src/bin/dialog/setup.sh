#!/bin/bash

envfile=$HOME"/.config/.sysenv";

home=$1;
home=${repo:-$SYSENV_HOME};

repo=$2;
repo=${repo:-$SYSENV_REPO};

userrepo=$3;
userrepo=${userrepo:-$SYSENV_DEFAULT_USER_REPO};

branch=$2
device=$(whoami)

if [ $(whoami) == "root" ]; then
  device=$(hostname)
fi

device=${branch:-$device};
device=${device:-$SYSENV_BRANCH};

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
            "User/device:"      3 1	"$device"   3 20 40 20 \
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
	    sysenv_save $params;

      route_back
		;;

	*)
		exit
		;;
	esac
done
