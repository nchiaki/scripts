#!/bin/bash
null=/dev/null
#
iam=`basename $0`
usage() {
	echo Usage
	echo $iam \<BlockStartStr\> \<BlockEndStr\> \<dispCnt\> \<file\> ...
	echo
	echo 指定ファイルの\<BlockStartStr\>と \<BlockEndStr\>で指定した間のデータを \<dispCnt\>件分表示する。
	echo 但し、\<dispCnt\>:=0 の時は抽出できた全データを表示する。
	echo "    " \*\)入れ子状態には対応していません。
}

if [ $# -lt 4 ]
then usage; exit 1;
fi

dspcnt=$3

for (( fnmz=4; fnmz<=$#; fnmz++ ))
do {
	eval fnm=\$$fnmz
	if grep -n "$1" $fnm 2> $null | sed -e 's/[ \t]/_/g' > /tmp/$iam.tmp
	then {
		echo ==== $fnm
		lps=0
		#cat /tmp/$iam.tmp
		for srcln in `cat /tmp/$iam.tmp`
		do {
			if [ 0 -lt $lps ]
			then echo ----
			fi
#			echo $srcln
			sno=`echo $srcln | sed -e "s/:.*//g"`
			eno=`tail -n +$sno $fnm | grep -n "$2" | head -n1 | sed -e "s/:.*//g"`
#			eno=$((eno - 1))
#			echo eno=$eno
#			grep -n -A $eno "$1" $fnm
			tail -n +$sno $fnm | head -n $eno
#			break
			lps=$((lps + 1))
			
			if [ $dspcnt -ne 0 ]
			then {
				if [ $dspcnt -le $lps ]
				then break;
				fi
			}
			fi
		} done
	}
	fi
} done