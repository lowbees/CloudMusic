import QtQuick 2.0
import QtQuick.Controls 2.1
TabButton {
    id: control
    width: 80
    height: 40

    property alias color: text.color
    property alias indicatorVisible: indicatorRect.visible

    contentItem: Text {
        id: text
        text: control.text
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 80
        implicitHeight: 40
        color: 'transparent'

        Rectangle {
            id: indicatorRect
            width: 60
            height: 2
            color: '#c62f2f'
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.NoButton
        }

    }
}
