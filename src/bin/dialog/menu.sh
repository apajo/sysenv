#!/bin/bash

sysenv_info () {
  echo "Info: \n
  User: $SYSENV_BRANCH \n
  Repo: $SYSENV_REPO \n
  Last synced:    00:00:00
  ";
}

returncode=0
while test $returncode != 1 && test $returncode != 250
do
  exec 3>&1
    returntext=`$DIALOG \
      --backtitle "$app_name $app_version" \
      --keep-tite \
      --title "Choose your action" \
      --default-item Dialog "$@" \
      --menu "$(sysenv_info)" 0 0 5 \
      Setup		"Setup Sysenv (repo, etc)" \
      Options		"Options (autosync, etc)" \
      Help	"Display help" \
      Readme	"Show readme" \
      Exit	"Exit SYSENV" \
    2>&1 1>&3`
    returncode=$?
  exec 3>&-

  show=`echo "$returntext" | sed -e 's/^/	/' | tr '[:upper:]' '[:lower:]' | xargs`

  case $returncode in
    $DIALOG_CANCEL)
        clear;
        exit;
      ;;
    $DIALOG_OK)
      route_go $show
      exit;
      ;;
    *)
      #. ./report-button
      exit
      ;;
  esac
done
