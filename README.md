# Qt Multiple tests

## Purpose 

The [Qt Test library](http://doc.qt.io/qt-5/qtest-overview.html), based on a lightweight philosophy, don't provide any facilities for run multiple tests cases in a single application. But that's can be a very useful feature for medium size applications.

**Qt Multiple tests** provide an easy solution : include an additionnal header and you are able to create several tests case in your test application. 

**Qt Multiple tests** is a rework on the original example provided by Rob Caldecott in his two of his posts : [ Running Multiple Unit Tests ](http://qtcreator.blogspot.fr/2009/10/running-multiple-unit-tests.html) and [Sample Multiple Unit Test Project ](http://qtcreator.blogspot.fr/2010/04/sample-multiple-unit-test-project.html).

## Features

* Simplicity of use. Just include the header to your project
* Running a single or all tests cases
* Support some Qt Test runner options. For example you can have XML report 
* Qt4 / Qt5 compatibility 
* For Qt4 : Provide the exception thrown test (as exists in Qt5)
* C++11 minimum 

## How to use it

1. Add the header file to your project
2. Create a test case. Register it using **`TEST_DECLARE`**
    ```cpp
#ifndef TESTDUMMY_HH_
#define TESTDUMMY_HH_

#include "MultiTests.hh"

class TestDummy : public QObject
{
    Q_OBJECT

private slots:
    // Test functions
    void showVersion(void){
       QCOMPARE(1,1);
    }
};

TEST_DECLARE(TestDummy);

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


## Next steps

This helpful project is still a work in progress and can be improved in many ways. 
We can list for the more important missing features : 
- Handling tests on that extension over Travis CI
- Better support for XML options. Specially handle output as single well formatted XML file and as multiple XML files.
- Run a selections of cases by repeat the `-case` options
- Define a license for the project


