 #ifndef TESTDUMMY_HH_
#define TESTDUMMY_HH_

#include "../../MultiTests.hh"

class Dummy_test : public QObject{
    Q_OBJECT

    private slots:
        // Test functions
        void obviousTest(void){
            QCOMPARE(1,1);
        }
};

TEST_DECLARE(Dummy_test);


MULTI_TESTS_MAIN

#endif /* TESTDUMMY_HH_ */
