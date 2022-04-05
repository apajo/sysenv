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
  home="/";
fi

branch=${branch:-$user};
branch=${branch:-$SYSENV_BRANCH};

sysenv_save () {
  sysenv_config_save "SYSENV_HOME"    ${params[0]};
  sysenv_config_save "SYSENV_REPO"    ${params[1]};
  sysenv_config_save "SYSENV_BRANCH"  ${params[2]};
}

sysenv_setup () {
  syadm clone "$SYSENV_REPO" -w "$SYSENV_HOME";exit;
  syadm checkout "$SYSENV_BRANCH" || :;
  syadm fetch

  exit;
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
            "Root directory:"         1 1	"$home"     1 20 40 50 \
            "Repository:"         2 1	"$repo"     2 20 40 50 \
            "Branch (user):"      3 1	"$branch"   3 20 40 20 \
          2>&1 1>&3`
    returncode=$?
  exec 3>&-

	case $returncode in
	$DIALOG_CANCEL)
		route_back
		;;
	$DIALOG_OK)
	    IFS=$'\n'
	    params=($returntext)
	    sysenv_save $params;
      sysenv_setup
exit;
      route_back
		;;

	*)
		exit
		;;
	esac
done
