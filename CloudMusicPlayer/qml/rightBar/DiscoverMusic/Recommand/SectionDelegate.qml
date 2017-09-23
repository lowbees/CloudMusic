import QtQuick 2.7
import '../../../others' as Other
Item {
    width: parent.width
    height: 40

    property alias text: section.text
    signal clicked()

    Text {
        id: section
        text: '推荐歌单'
        font.pointSize: 16
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
    Text {
        text: '更多>'
        font.pointSize: 12
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
    Other.Line {
        width: parent.width
        anchors.bottom: parent.bottom
    }
}
