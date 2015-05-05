#ifndef FIRSTCASE_HH_
#define FIRSTCASE_HH_

#include "../../MultiTests.hh"

class FirstCase_test : public QObject{
    Q_OBJECT

    private slots:
        // Test functions
        void obviousTest(void){
            QCOMPARE(1,1);
        }
};

TEST_DECLARE(FirstCase_test);

#endif /* FIRSTCASE_HH_ */
