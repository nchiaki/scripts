#!/bin/bash
Iam=`basename $0`
null=/dev/null
#
usage() {
	echo Usage:
	echo $Iam \<ProductName\> \<IgnorVer\> \<Generation\>
	echo 
	echo tarballアーカイブの世代管理。
	echo 指定した世代以前の tarballを削除する。
	echo 対象のtarballの名称は次の形式を取ること。
	echo \<ProductName\>\[_\<Ver\>\].tar.gz
	echo \<IgnorVer\>指定した\<Ver\>を持つtarballと _\<Ver\>が付与されていない tarballは処理の対象外とする。
	exit 1
}

if [ $# -lt  3 ]
then usage
fi

tgtcnt=0
for fnm in `ls $1*.tar.gz | sort 2> $null`
do {
	trgt=`echo $fnm | grep -v _$2.tar.gz`
	if [ "$trgt" != "" ]
	then {
		if [ "$trgt" != "$1.tar.gz" ]
		then tgtcnt=$((tgtcnt + 1))
		fi
	}
	fi
} done

if [ $tgtcnt -le $3 ]
then exit 0
fi

for fnm in `ls $1*.tar.gz | sort 2> $null`
do {
	trgt=`echo $fnm | grep -v _$2.tar.gz`
	if [ "$trgt" != "" ]
	then {
		if [ "$trgt" != "$1.tar.gz" ]
		then {
			if [ $3 -lt $tgtcnt ]
			then {
				#echo $trgt
				rm -i $trgt
				tgtcnt=$((tgtcnt - 1))
			}
			fi
		}
		fi
	}
	fi
	
	if [ $tgtcnt -le $3 ]
	then break
	fi
} done

#echo ... done
