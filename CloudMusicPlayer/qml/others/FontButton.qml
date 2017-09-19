import QtQuick 2.7

Text {

    property color normalColor: 'black'
    property color hoverColor: normalColor
    property color pressColor: hoverColor

    font.family: 'icomoon'
    font.pointSize: 20
    font.bold: false
    color: normalColor

    signal clicked
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            parent.color = pressColor
            parent.clicked()
        }
        onEntered: parent.color = hoverColor
        onExited: parent.color = normalColor
    }

    Behavior on color {
        NumberAnimation { duration: 500 }
    }
}
