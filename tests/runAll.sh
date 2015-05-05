#!/bin/bash
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly ARGS_ARRAY=($@)

# Constants
readonly BIN_RUNNER=multiTestsCaseRunner
readonly SPECIFIC_SCRIPT=specific.sh
readonly RUNNER_OUTPUT=output.log

testConfig(){
    # Configure bash environment for test execution
    set -ev # Verbose mode and exit script as soon as one command fail
}

usage() {
    echo "Script for run a bunch of test on qt-multiple-tests project"
    echo "Each test is  a directory containing a Qt QTest simple project"
    echo "That will be run"
    echo "Usage : $PROGNAME [options]"
    echo " "
    echo "Options : "
    echo "--verbose  -v : Output compilation and each of project runner"

    echo " "
    echo "--help     -h : Display this Help on usage"
}

cmdline() {
    # got this idea from here:
    # http://kirk.webfinish.com/2009/10/bash-shell-script-to-use-getopts-with-gnu-style-long-positional-parameters/
    local arg=
    for arg
    do
        local delim=""
        case "$arg" in
            #translate --gnu-long-options to -g (short options)
            --help)           args="${args}-h ";;
            --verbose)          args="${args}-v ";;
            #pass through anything else
            *) [[ "${arg:0:1}" == "-" ]] || delim="\""
                args="${args}${delim}${arg}${delim} ";;
        esac
    done

    #Reset the positional parameters to the short options
    eval set -- $args

    while getopts "hv" OPTION
    do
         case $OPTION in
         h)
             usage
             exit 0
             ;;
         v)
             readonly MODE_VERBOSE=1
             ;;
        esac
    done

    return 0
}

projectClean(){
    rm -f $BIN_RUNNER $RUNNER_OUTPUT
}
projectPrepare(){
    qmake -project
    echo "include(../base.pri)" >> *.pro
    qmake
}
projectCompile(){
    if [[ -n $MODE_VERBOSE ]]; then
        make
    else
        make 1> /dev/null
    fi
}
projectRun(){
    ./$BIN_RUNNER &> $RUNNER_OUTPUT || true
    if [[ -n $MODE_VERBOSE ]]; then
        cat $RUNNER_OUTPUT
    fi
    if [ -e "$SPECIFIC_SCRIPT" ]
    then
        echo "=> $SPECIFIC_SCRIPT is launched"
        ./$SPECIFIC_SCRIPT
    fi
}


proceedAllTests(){
    for dir in ./tests/*/
    do
        dir=${dir%*/}
        echo "== Case "${dir##*/}" == "

        cd $dir
        projectClean
        projectPrepare
        projectCompile
        projectRun
        cd ../../

    done
}

main() {
    cmdline $ARGS
    testConfig

    proceedAllTests
}

main
