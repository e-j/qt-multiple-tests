#!/bin/bash
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly ARGS_ARRAY=($@)

# Constants
readonly BIN_RUNNER=multiTestsCaseRunner
readonly SPECIFIC_SCRIPT=specific.sh
readonly RUNNER_OUTPUT=output.log
readonly CONFIGURATION_FILENAME=test.conf

testConfig(){
    # Configure bash environment for test execution
    source $PROGDIR/resultParsing.sh
    set -e # Exit script as soon as one command fail
}

usage() {
    echo "Script for run a bunch of test on qt-multiple-tests project"
    echo "Each test is  a directory containing a Qt QTest simple project"
    echo "That will be run"
    echo "Usage : $PROGNAME [options]"
    echo " "
    echo "Options : "
    echo "--verbose  -v : Output compilation and each of project runner"
    echo "--clean    -c : Clean project directory before compile and after success"

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
            --clean)          args="${args}-c ";;
            --verbose)        args="${args}-v ";;
            #pass through anything else
            *) [[ "${arg:0:1}" == "-" ]] || delim="\""
                args="${args}${delim}${arg}${delim} ";;
        esac
    done

    #Reset the positional parameters to the short options
    eval set -- $args

    while getopts "hvc" OPTION
    do
         case $OPTION in
         h)
             usage
             exit 0
             ;;
         v)
             readonly MODE_VERBOSE=1
             ;;
         c)
             readonly MODE_CLEANING=1
             ;;
        esac
    done

    return 0
}

echoWhenVerbose(){
    if [[ -n $MODE_VERBOSE ]]; then
        echo $1
    fi
}

projectClean(){
    rm -f $BIN_RUNNER $RUNNER_OUTPUT
    rm -f Makefile *.pro
    rm -rf moc/ obj/
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

    echoWhenVerbose "==> Launch ./$BIN_RUNNER $runnerOptions"
    ./$BIN_RUNNER $runnerOptions &> $RUNNER_OUTPUT || true
    if [[ -n $MODE_VERBOSE ]]; then
        cat $RUNNER_OUTPUT
    fi
}

testConfigurationUnset(){
    runnerOptions=""
    checkNbCases=""
    # Pseudo-Associative map of checks for log content
    unset checksStr
    declare -a checksStr
    # Pseudo-Associative map of checks for file exists
    unset checksFileExist
    declare -a checksFileExist
}

testConfigurationLoad(){
    echoWhenVerbose "=> Load configuration from file"
    source $CONFIGURATION_FILENAME

    local re='^[0-9]+$'
    if ! [[ $checkNbCases =~ $re ]] ; then
        checkNbCases="0"
    fi
}

testChecks(){
    logParse

    testIntEqual $checkNbCases $nbCaseStarted "Number of tests cases"

    for currentCheckStr in "${checksStr[@]}" ; do
        local key=${currentCheckStr%%=*}
        local value=${currentCheckStr#*=}
        testLogContain "$value" "$key"
    done

    for currentCheckFileExist in "${checksFileExist[@]}" ; do
        local key=${currentCheckFileExist%%=*}
        local value=${currentCheckFileExist#*=}
        testFileExist "$value" "$key"
    done
}

testCurrentDir(){
    if [ -e "$CONFIGURATION_FILENAME" ]; then
        echo "> Case "${dir##*/}" "

        testConfigurationUnset
        testConfigurationLoad

        if [[ -n $MODE_CLEANING ]]; then
            projectClean
        fi

        projectPrepare
        projectCompile
        projectRun

        testChecks

        if [[ -n $MODE_CLEANING ]]; then
            projectClean
        fi
    fi

}

proceedAllTests(){
    for dir in ./tests/*/
    do
        dir=${dir%*/}

        cd $dir
        testCurrentDir
        cd ../../

    done
}

main() {
    cmdline $ARGS
    testConfig

    proceedAllTests

    exit $scriptSuccess
}

main
