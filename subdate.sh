#!/usr/bin/env bash

#echo $0 $#

usage() {
    echo $0 \<after_date_result\> \<pre_date_result\>
}

if [ $# -lt 2 ]
then usage; exit 0
elif [ $1 = "-h" ]
then usage; exit 0
fi

tmstr=()
tx=0
for x in `seq 1 $#`
do {
  #echo ${!x}
  if [ ${!x} = 'JST' ]
  then {
    y=$((x - 1))
    tmstr[$tx]=${!y}
    tx=$((tx  + 1))
  }
  fi
} done
#echo ${tmstr[0]} - ${tmstr[1]}
strtm=(${tmstr[1]//:/ })
endtm=(${tmstr[0]//:/ })

strsec=0
for x in `seq 0 $((${#strtm[@]} - 1))`
do {
  nm=`expr ${strtm[$x]} \* 1`
  if [ $x -eq 0 ]
  then {
    nm=`expr $nm \* 3600`
    strsec=$((strsec + nm))
  }
  elif [ $x -eq 1 ]
  then {
    nm=`expr $nm \* 60`
    strsec=$((strsec + nm))
  }
  else strsec=$((strsec + $nm))
  fi
} done
#echo $strsec

endsec=0
for x in `seq 0 $((${#endtm[@]} - 1))`
do {
  nm=`expr ${endtm[$x]} \* 1`
  if [ $x -eq 0 ]
  then {
    nm=`expr $nm \* 3600`
    endsec=$((endsec + nm))
  }
  elif [ $x -eq 1 ]
  then {
    nm=`expr $nm \* 60`
    endsec=$((endsec + nm))
  }
  else endsec=$((endsec + $nm))
  fi
} done
#echo $endsec

ttlsec=$((endsec - strsec))
ttlmin=`expr $ttlsec / 60`
dspsec=`expr $ttlsec - \( $ttlmin \* 60 \)`
echo $ttlmin:$dspsec \($ttlsec\)
