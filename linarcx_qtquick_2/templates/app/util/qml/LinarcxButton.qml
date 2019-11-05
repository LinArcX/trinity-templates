import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.Button {
    id: control

    // Mandatories
    property int btnTextPos: 4
    property int btnIconPos: 2
    property string btnText
    property string btnIcon
    property string btnIconColor
    property string btnIconFamily

    // Optional
    property int btnTextSize
    property int btnIconSize
    property string btnTextColor

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    horizontalPadding: padding + 2
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: control.checked
                || control.highlighted ? control.palette.brightText : control.flat
                                         && !control.down ? (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        font: control.font
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        color: control.checked
               || control.highlighted ? control.palette.brightText : control.flat
                                        && !control.down ? (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText
        Text {
            id: mText
            clip: true
            text: btnText
            color: btnTextColor ? btnTextColor : "black"
            font.pixelSize: btnTextSize ? btnTextSize : 15

            Component.onCompleted: {
                if (btnTextPos == 0) {
                    // Left
                    anchors.left = parent.left
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnTextPos == 1) {
                    // Right
                    anchors.right = parent.right
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnTextPos == 2) {
                    // Left of Icon
                    anchors.right = mIcon.left
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnTextPos == 3) {
                    // Right of Icon
                    anchors.left = mIcon.right
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else {
                    // Center
                    anchors.centerIn = parent
                    anchors.verticalCenter = parent.verticalCenter
                }
            }
        }

        Text {
            id: mIcon
            text: btnIcon
            font.family: btnIconFamily
            font.pixelSize: btnIconSize ? btnIconSize : 18
            color: btnIconColor ? btnIconColor : "white"

            Component.onCompleted: {

                if (btnIconPos == 0) {
                    // Left
                    anchors.left = parent.left
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnIconPos == 1) {
                    // Right
                    anchors.right = parent.right
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnIconPos == 2) {
                    // Left of Icon
                    anchors.right = mText.left
                    anchors.rightMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else if (btnIconPos == 3) {
                    // Right of Icon
                    anchors.left = mText.right
                    anchors.leftMargin = 5
                    anchors.verticalCenter = parent.verticalCenter
                } else {
                    // Center
                    anchors.centerIn = parent
                    anchors.verticalCenter = parent.verticalCenter
                }
            }
        }
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        visible: !control.flat || control.down || control.checked
                 || control.highlighted
        color: Color.blend(
                   control.checked
                   || control.highlighted ? control.palette.dark : control.palette.button,
                                            control.palette.mid,
                                            control.down ? 0.5 : 0.0)
        border.color: control.palette.highlight
        border.width: control.visualFocus ? 2 : 0
    }
}
