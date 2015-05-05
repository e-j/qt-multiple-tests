#ifndef SECONDCASE_HH_
#define SECONDCASE_HH_

#include "../../MultiTests.hh"

class SecondCase_test : public QObject{
    Q_OBJECT

    private slots:
        // Test functions
        void failure(void){
            QCOMPARE(1,3);
        }
        void anotherFailure(void){
            QFAIL("test");
        }
};

TEST_DECLARE(SecondCase_test);

#endif /* SECONDCASE_HH_ */
