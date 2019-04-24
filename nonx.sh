#!/bin/bash
iam=`basename $0`

usage() {
	echo Usage:
	echo $iam
	echo
	echo README* Makefile *.[ch] *.html *.css　から実行権を取る
	exit 1;
}

if [ $# -ne 0 ]
then usage
fi

chmod a-x README* Makefile *.[ch] *.html *.css 2> /dev/null
