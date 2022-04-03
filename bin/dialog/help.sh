#!/bin/bash

returncode=0
while test $returncode != 1 && test $returncode != 250
do
  exec 3>&1
    $DIALOG --title "MESSAGE BOX" --clear "$@" \
          --backtitle "$app_name $app_version" \
            --msgbox "Hi, this is a simple message box. You can use this to \
                      display any message you like. The box will remain until \
                      you press the ENTER key." 10 41

    returncode=$?
  exec 3>&-

	case $returncode in
	*)
		route_back
		;;
	esac
done
