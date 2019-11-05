import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.0

import "qrc:/components/qml/"
import "qrc:/pages/"
import "qrc:/fonts/hack/"
import "qrc:/js/Constants.js" as CONS
import LauncherClass 1.0

Window {
    id: window
    visible: true
    LayoutMirroring.enabled: isRTL
    LayoutMirroring.childrenInherit: true

    property string listProjects: "qrc:/pages/ListProjects.qml"
    property string path

    LinarcxToolTip {
        id: qToolTip
        mother: window
        z: 900
    }

    StackView {
        id: qStackView
        width: parent.width
        height: parent.height - 50
        anchors.right: parent.right
        anchors.top: parent.top
    }

    LauncherClass {
        id: qLC
    }

    Rectangle {
        id: qMenu
        color: "#424242" //"#767676"
        width: parent.width
        height: 50
        anchors.top: qStackView.bottom

        //width: 50
        //height: parent.height
        //anchors.left: parent.left

        ListModel {
            id: qModel
        }

        LinarcxImageToolTiper {
            id: qSettings
            qImg: "qrc:/images/settings.svg"
            sourceSize.height: 40
            sourceSize.width: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            onImageClicked: qStackView.push("qrc:/pages/Settings.qml")
            onImageEntered: qToolTip.showMe(x, y, 2, qsTr("Settings"))
        }
    }

    Component {
        id: qShortCut

        Shortcut {
            id: scReloadQML
            sequences: ["F5"]
            context: Qt.WindowShortcut
            onActivated: {
                RuntimeQML.reload()
                console.log("Reloading...")
            }
        }
    }

    Component.onCompleted: {
        window.minimumWidth = Screen.width / 3 * 2
        window.minimumHeight = Screen.height / 3 * 2
        window.maximumWidth = Screen.width
        window.maximumHeight = Screen.height
        window.x = Screen.width / 2 - window.minimumWidth / 2
        window.y = Screen.height / 2 - window.minimumHeight / 2
        qStackView.push("qrc:/pages/Settings.qml")

        if (Qt.platform.os === 'android') {
            console.log("Android Platfrom!")
        } else if (Qt.platform.os === 'linux') {
            console.log("Linux Platfrom!")
        }

        console.log(engine)
        console.log(app)
        console.log(isRTL)
    }
}
