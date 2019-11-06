############### General ###############
QT += core qml quick quickcontrols2 widgets
CONFIG += c++11

VERSION = $$system(git log --pretty=format:'%h' -n 1)
DEFINES += APP_VER=\\\"$$VERSION\\\"
DEFINES += QT_DEPRECATED_WARNINGS QT_NO_DEBUG_OUTPUT QT_NO_WARNING_OUTPU

############### Compiler Flgas ###############
QMAKE_CXXFLAGS_WARN_OFF -= -Wunused-parameter

############### Resources ###############
SOURCES += $$files(modules/*.cpp, true) \
           $$files(util/cpp/*.cpp, true)

HEADERS += $$files(modules/*.h, true) \
           $$files(util/cpp/*.h, true)

RESOURCES += qml.qrc

############### Other files ###############
OTHER_FILES += LICENSE\
            README.md\
            .gitignore

############### Platform Specific actions ###############
linux:!android{
    message("Linux building...")
    unix: CONFIG += link_pkgconfig
    #unix: PKGCONFIG += libYaml
}

android {
    message("Android building...")

    QMAKE_LINK += -nostdlib++
    QT += androidextras xml svg
    QTPLUGIN += qsvg qsvgicon
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}

win32 {
    !contains(QMAKE_TARGET.arch, x86_64) {
        message("Windows x86 building...")

    } else {
        message("Windows x86_64 building...")
    }
}

############### Deployment ###############
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

CONFIG(debug, debug|release) {
    # do debug things here
    # message("Copying to Debug Directroy!")
    #include(runtimeqml/runtimeqml.pri)
    #DEFINES += "QRC_RUNTIME_SOURCE_PATH=\\\"$$PWD\\\""
}
CONFIG(release, debug|release) {
    # do release things here
}
