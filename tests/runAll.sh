#!/bin/bash

testConfig(){
    # Configure bash environment for test execution
    set -ev # Verbose mode and exit script as soon as one command fail
}

projectClean(){
    rm -f multiTestsCase
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
    ./multiTestsCase
}


proceedAllTests(){
    for dir in ./*/
    do
        dir=${dir%*/}
        echo "== Case "${dir##*/}" == "

        cd $dir
        projectClean
        projectPrepare
        projectCompile
        projectRun
        cd ..

    done
}

main() {
    testConfig
    proceedAllTests
}

main
