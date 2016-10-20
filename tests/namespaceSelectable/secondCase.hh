#ifndef SECONDCASE_HH_
#define SECONDCASE_HH_

#include "../../MultiTests.hh"

namespace test_space{
class SecondCase_test : public QObject{
    Q_OBJECT

    private slots:
        // Test functions
        void obviousTest(void){
            QCOMPARE(1,1);
        }
};

TEST_DECLARE(SecondCase_test);

}

#endif /* SECONDCASE_HH_ */
