#!/bin/bash

autosync=$1;
autosync=${repo:-$SYSENV_AUTOSYNC_DELAY};


sysenv_save () {
  sysenv_config_save "SYSENV_AUTOSYNC_DELAY"    ${params[0]};
}

returncode=0
while test $returncode != 1 && test $returncode != 250
do
  ##--output-separator " " \
  exec 3>&1
    returntext=`$DIALOG --ok-label "Submit" \
        --backtitle "$app_name $app_version" \
        --form "Change yuor sysenv options" \
          10 60 0 \
            "Autos sync delay (secs):"         1 1	"$autosync"     1 25 40 3 \
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
