#!/bin/bash

scriptSuccess=0

log(){
    # Log a successfull step
    # param1 : decription of step
    echo "===> [OK]   $1"
}

error(){
    # Log a failure step (and set scriptSuccess to failure status)
    # param1 : decription of step
    echo "===> [FAIL] $1"
    scriptSuccess=1
}

testIntEqual(){
    # Test that two integers are equals
    # param1 : The expected value
    # param2 : The value we get
    # param3 : Description of test
    if [ $1 -ne $2 ]
    then
        error "$3 : expected $1, get $2"
        exit 1
    else
        log "$3 : (get $1)"
    fi
}

logParse(){
    # Parse log result for extract important metrics
    nbCaseStarted=`grep -o "Start testing of " output.log | wc -l`
}

logContain(){

}
