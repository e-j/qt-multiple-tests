#!/bin/bash
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly ARGS_ARRAY=($@)


source ../resultParsing.sh

logParse
testIntEqual 3 $nbCaseStarted "Number of tests cases"
testLogContain "All tests succeed" "All test succeed"

exit $scriptSuccess
