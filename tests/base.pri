# Outputs directories
MOC_DIR = ./moc
RCC_DIR = ./rcc
OBJECTS_DIR = ./obj

# C++11 options
CONFIG += c++11
QMAKE_CXXFLAGS += -std=c++11

# Flag Qt Version
greaterThan(QT_MAJOR_VERSION, 4): DEFINES += QT5
lessThan(QT_MAJOR_VERSION, 5): CONFIG += qtestlib
greaterThan(QT_MAJOR_VERSION, 4): QT += testlib widgets

# For more simplicity, all targets have same name
TARGET = multiTestsCase 
