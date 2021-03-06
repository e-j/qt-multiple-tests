# Qt Multiple tests [![Build Status](https://travis-ci.org/e-j/qt-multiple-tests.svg?branch=master)](https://travis-ci.org/e-j/qt-multiple-tests)

## Purpose

The [Qt Test library](http://doc.qt.io/qt-5/qtest-overview.html), as based on a lightweight philosophy, don't provide any facilities for run multiple tests cases in a single application. But that's can be a very useful feature for medium size applications.

**Qt Multiple tests** provide an easy solution : include an additionnal header and you are able to create several tests cases in your test suite. A single binary will allow to run one or all test cases. Reporting and re-run test is simplified. Parsing unit tests results will be simplified for external tools (IDE, continuous integration)

**Qt Multiple tests** is a rework on a original example provided by Rob Caldecott in his two of his posts : [Running Multiple Unit Tests ](http://qtcreator.blogspot.fr/2009/10/running-multiple-unit-tests.html) and [Sample Multiple Unit Test Project ](http://qtcreator.blogspot.fr/2010/04/sample-multiple-unit-test-project.html).

## Features

* Simplicity of use : just include the header [`MultiTests.hh`](MultiTests.hh) to your project
* Choose to run all or a selection of the test case : option `-case <casename>`
* List all tests functions from a case (or all cases) : option `-functions`
* Summary of tests results in verbose output
* Support some Qt Test runner options. For example you can have XML report
* Qt4 / Qt5 compatibility
* For Qt4 : Provide the exception thrown test (as exists in Qt5)

## Requirements
* A Qt application in QTest mode
    - For Qt4 : `CONFIG += qtestlib`
    - For Qt5 : `QT += testlib widgets`


## How to use it

1. Add the [`MultiTests.hh`](MultiTests.hh) file to your project
2. Create a test case. Register it using **`TEST_DECLARE`**

```cpp
#ifndef TESTDUMMY_HH_
#define TESTDUMMY_HH_

#include "MultiTests.hh"

class Dummy_test : public QObject
{
    Q_OBJECT

private slots:
    // Test functions
    void obviousTest(void){
       QCOMPARE(1,1);
    }
};

TEST_DECLARE(Dummy_test);

#endif /* TESTDUMMY_HH_ */
```

3. When you want to compile the unit tests, just run the **`MULTI_TESTS_MAIN`** instead of your `main` function :

```cpp
#ifdef UNITTEST_MODE
    #include "MultiTests.hh"
    MULTI_TESTS_MAIN
    // Else run normal main function
#endif
```
4. Compile the application and run it : the test case is executed
5. Repeat the step 2 for add more tests cases


Example of execution :

```
********* Start testing of Dummy_test *********
Config: Using QTest library 4.8.6, Qt 4.8.6
PASS   : Dummy_test::initTestCase()
PASS   : Dummy_test::obviousTest()
PASS   : Dummy_test::cleanupTestCase()
********* Finished testing of Dummy_test *********
********* Start testing of StylesHandler_test *********
Config: Using QTest library 4.8.6, Qt 4.8.6
PASS   : StylesHandler_test::initTestCase()
FAIL!  : StylesHandler_test::totalFailure() Compared values are not the same
   Actual (m_data->content()): In7sh4oaZj6G0gf
   Expected (QString("153")): 153
   Loc: [tests/StylesHandler_test.cpp(67)]
PASS   : StylesHandler_test::styleExist()
PASS   : StylesHandler_test::cleanupTestCase()
Totals: 4 passed, 0 failed, 0 skipped
********* Finished testing of StylesHandler_test *********
********* Start testing of VarTypes_test *********
Config: Using QTest library 4.8.6, Qt 4.8.6
PASS   : VarTypes_test::initTestCase()
PASS   : VarTypes_test::varUnknowUndefined()
PASS   : VarTypes_test::varSearchValue()
PASS   : VarTypes_test::cleanupTestCase()
Totals: 10 passed, 0 failed, 0 skipped
********* Finished testing of VarTypes_test *********
========================================
========================================
======= ERRORS during tests !!!   =======
1 error in 1 case(s), over a total of 3 tests cases
Case(s) that failed :  StylesHandler_test
Executed in 0 seconds (49 ms)
```

## License

This project is under LGPLv3.
See the [LICENSE](LICENSE.md) file for license rights and limitations


## Next steps

This helpful project is still a work in progress and can be improved in many ways.
Missing features and to do work are listed into the issues section.
