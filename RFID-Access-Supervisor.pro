TEMPLATE = app

QT += qml quick widgets
QT += serialport
QT += sql
QT += multimedia

SOURCES += main.cpp \
    databasemanager.cpp \
    sounds.cpp \
    rxTxThread.cpp \
    session.cpp \
    services.cpp \
    model_userlist.cpp \
    model_log.cpp \
    qtquick2applicationviewer/qtquick2applicationviewer.cpp


HEADERS += \
    databasemanager.h \
    sounds.h \
    rxTxThread.h \
    session.h \
    services.h \
    model_userlist.h \
    model_log.h \
    qtquick2applicationviewer/qtquick2applicationviewer.h


RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
