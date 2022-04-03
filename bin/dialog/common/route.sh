#!/bin/bash

ROUTE=()

route_go () {
  export IFS="/"
  sentence=$1

  for word in $sentence; do
      case $word in
        ".")
            #
          ;;
        "..")
          unset ROUTE[${#ROUTE[@]}-1];
          ;;
        "")
          ROUTE=();
          ;;
        *)
          ROUTE+=($word)
          ;;
      esac
  done

  route_exec;
}

route_back () {
  if [ ${#ROUTE[@]} -eq 0 ]; then
    clear:
    exit;
  else
    current=${ROUTE[-1]};
    unset ROUTE[${#ROUTE[@]}-1];

    route_exec;
  fi

  route_exec
}

route_exec () {
  current=${ROUTE[-1]}

  echo "Route: [$current]";
  . "$SYSENV/bin/dialog/$current".sh
}
