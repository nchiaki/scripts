#!/bin/bash

oldurls=()

usage() {
  echo $1 \<URL\> \<NextLevel\>
}

surf() {
  urls=`curl $1 2> /dev/null | grep href= | sed "s/.* href=\"//" | sed -s "s/\".*//" | grep ^http`
  nstlvl=$((nstlvl + 1))
  for url in $urls
  do {
    newurl=1
    for oldurl in ${oldurls[@]}
    do {
      #echo OLDURLS:$oldurl
      if [ "$oldurl" = "$url" ]
      then {
        newurl=0
        break
      }
      fi
    } done
    if [ $newurl -eq 0 ]
    then {
      #echo Alredy:$url;
      continue;
    }
    fi
    oldurls+=($url)
    #echo OLDURLS:${oldurls[@]}

    echo \[$nstlvl\]$url
    if [ $mxnst -le $nstlvl ]
    then continue
    fi
    surf $url
  } done
  nstlvl=$((nstlvl - 1))
}

if [ $# -lt 2 ]
then {
  usage $0
  exit
}
fi

mxnst=$2

if [ $mxnst -lt 1 ] || [ 1000 -lt $mxnst ]
then {
  usage $0
  exit
}
fi

nstlvl=0
surf $1
