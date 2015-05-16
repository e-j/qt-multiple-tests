# Outputs directories
MOC_DIR = ./moc
RCC_DIR = ./rcc
OBJECTS_DIR = ./obj

# C++11 options
_QT_BASE = $(QT_BASE)

message("_QT_BASE = $(_QT_BASE) ")
message("$ = $(QT_BASE)")
message("££ = $$(QT_BASE)")

isEmpty(_QT_BASE){
  message("_QT_BASE is empty")
}
isEmpty( $(QT_BASE) ){
  message("$ is empty")
}
isEmpty( $$(QT_BASE) ){
  message("££ is empty")
}

!equals( _QT_BASE, "48cpp98") {
#!system( g++ --version | grep -e "4\.6.[0-9]" ) {
    CONFIG += c++11
    QMAKE_CXXFLAGS += -std=c++11
}

# Flag Qt Version
greaterThan(QT_MAJOR_VERSION, 4): DEFINES += QT5
lessThan(QT_MAJOR_VERSION, 5): CONFIG += qtestlib
greaterThan(QT_MAJOR_VERSION, 4): QT += testlib widgets

# For more simplicity, all targets have same name
TARGET = multiTestsCaseRunner
