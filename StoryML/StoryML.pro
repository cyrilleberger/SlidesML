TEMPLATE = app

QT += qml quick widgets KSyntaxHighlighting quickcontrols2
CONFIG += C++11

SOURCES += main.cpp Extension.cpp
HEADERS += Extension.h

RESOURCES += StoryML.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = ..

# Default rules for deployment.
include(../deployment.pri)

OTHER_FILES += qml/main.qml
OTHER_FILES += qml/StoryML/* qml/StoryML/Components/* qml/StoryML/Components/Diagram/* qml/StoryML/Components/Lines/* qml/StoryML/Layouts/* qml/StoryML/StoryTellers/* qml/StoryML/Styles/* qml/StoryML/Viewer/*

DISTFILES += \
    qml/StoryML/Components/Lines/MediasLine.qml
