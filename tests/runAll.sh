#!/bin/bash
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly ARGS_ARRAY=($@)

# Constants
readonly BIN_RUNNER=multiTestsCaseRunner

testConfig(){
    # Configure bash environment for test execution
    set -ev # Verbose mode and exit script as soon as one command fail
}

projectClean(){
    rm -f $BIN_RUNNER
}
projectPrepare(){
    qmake -project
    echo "include(../base.pri)" >> *.pro
    qmake
}
projectCompile(){
    make
}
projectRun(){
    ./$BIN_RUNNER
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
    testConfig
    proceedAllTests
}

main
