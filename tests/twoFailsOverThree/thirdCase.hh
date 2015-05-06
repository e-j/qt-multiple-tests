#ifndef THIRDCASE_HH_
#define THIRDCASE_HH_

#include "../../MultiTests.hh"

class ThirdCase_test : public QObject{
    Q_OBJECT

    private slots:
        // Test functions
        void failureToo(void){
            QVERIFY(false);
        }
};

TEST_DECLARE(ThirdCase_test);

#endif /* THIRDCASE_HH_ */
