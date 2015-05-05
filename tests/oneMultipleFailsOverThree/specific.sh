#!/bin/bash
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly ARGS_ARRAY=($@)


source ../resultParsing.sh

logParse
testIntEqual 3 $nbCaseStarted "Number of tests cases"
testLogContain "ERRORS during tests" "Error detected"
testLogContain "2 error in 1 case(s), over a total of 3 tests cases" "Error count"
testLogContain "Case(s) that failed :  SecondCase_test" "Detect failing case"

exit $scriptSuccess
