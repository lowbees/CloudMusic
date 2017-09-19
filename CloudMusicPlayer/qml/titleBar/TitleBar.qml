import QtQuick 2.7

Rectangle {
    height: 50
    color: '#c62f2f'

    Image {
        source: 'qrc:/images/title.png'
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 15
    }

    MouseArea {
        anchors.fill: parent
        property point pressPos: '0, 0'
        onPressed: pressPos = Qt.point(mouse.x, mouse.y)
        onPositionChanged: {
            rootWindow.x += mouse.x - pressPos.x
            rootWindow.y += mouse.y - pressPos.y
        }
    }
}
