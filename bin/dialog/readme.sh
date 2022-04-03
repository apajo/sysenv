#!/bin/bash

filepath=$(realpath "$SYSENV/README.md")

returncode=0
while test $returncode != 1 && test $returncode != 250
do
  exec 3>&1
    $DIALOG --title "Read me" --clear "$@" \
            --backtitle "$app_name $app_version" \
            --textbox "$filepath" 30 70

    returncode=$?
  exec 3>&-

	case $returncode in
    $DIALOG_CANCEL)
		  route_back;
      ;;
    $DIALOG_OK)
		  route_back;
      ;;
	esac
done
