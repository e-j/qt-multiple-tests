#!/bin/bash
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly ARGS_ARRAY=($@)


source ../resultParsing.sh

parseLog
testIntEqual 1 $nbCaseStarted "Number of tests cases"
exit $scriptSuccess
