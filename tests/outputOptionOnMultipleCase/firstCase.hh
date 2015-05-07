#ifndef FIRSTCASE_HH_
#define FIRSTCASE_HH_

#include "../../MultiTests.hh"

#include <QString>

class FirstCase_test : public QObject{
    Q_OBJECT

    private slots:
        // Test functions
        void regExTestser(void){
            QString regEx = ".*_\\d+$";
            
            QVERIFY( !QString("test").contains( QRegExp(regEx) ) );
            QVERIFY( !QString("test1").contains( QRegExp(regEx) ) );
            QVERIFY( QString("test_1").contains( QRegExp(regEx) ) );
            QVERIFY( QString("test_00").contains( QRegExp(regEx) ) );
            QVERIFY( QString("test_11").contains( QRegExp(regEx) ) );
            QVERIFY( QString("test_00001").contains( QRegExp(regEx) ) );
            QVERIFY( !QString("test_a").contains( QRegExp(regEx) ) );
            QVERIFY( !QString("test_ad1").contains( QRegExp(regEx) ) );
            QVERIFY( QString("test_1_1").contains( QRegExp(regEx) ) );
            QVERIFY( !QString("test_1_a").contains( QRegExp(regEx) ) );
        }
};

TEST_DECLARE(FirstCase_test);

#endif /* FIRSTCASE_HH_ */
