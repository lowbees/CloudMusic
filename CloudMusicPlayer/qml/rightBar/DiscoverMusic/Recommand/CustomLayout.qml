import QtQuick 2.7
import QtQuick.Controls 2.1
//  根据个人喜好，更改顺序
Item {
    height: 160
    width: parent.width

    Rectangle {
        width: parent.width
        height: 1
        color: '#f0f0f0'
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: '现在可以根据个人喜好，自由调整栏目顺序啦~'
        anchors.bottom: button.top
        anchors.bottomMargin: 20
    }

    Rectangle {
        id: button
        anchors.centerIn: parent
        width: 120
        height: 30
        radius: 3
        border.width: 1
        border.color: '#c62f2f'

        Text {
            anchors.centerIn: parent
            color: '#c62f2f'
            text: '调整栏目顺序'
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {

                popup.model = dirtyModel
                popup.open()
                console.log(popup.x, popup.y)
            }
        }
    }

    ListModel {
        id: dirtyModel
        ListElement { sourceUrl: 'Personalized.qml'; name: '推荐歌单' }
        ListElement { sourceUrl: 'Privatecontent.qml'; name: '独家放送' }
        ListElement { sourceUrl: 'NewSong.qml'; name: '最新音乐' }
        ListElement { sourceUrl: 'MV.qml'; name: '推荐MV' }
        ListElement { sourceUrl: 'RadioDJ.qml'; name: '主播电台' }
    }

    function changeLayout() {
        for (var i = 0; i < dirtyModel.count - 1; ++i) {
            for (var j = i + 1; j < recommandModel.count - 1; ++j)
                if (dirtyModel.get(i).name === recommandModel.get(j).name) {
                    recommandModel.move(j, i + 1, 1)
                    break
                }
        }
    }

    Component.onCompleted: popup.closed.connect(changeLayout)

//    LDialog {
//        id: popup
//        x: (rootWindow.width - width) / 4
//        y: (rootWindow.height - rootWindow.header.height - rootWindow.footer.height - height) / 2


//        Component.onCompleted: console.log(x, y)
////        onXChanged: console.log(x, y)

//        onClosed: {
//            for (var i = 0; i < dirtyModel.count - 1; ++i) {
//                for (var j = i + 1; j < recommandModel.count; ++j)
//                    if (dirtyModel.get(i).name === recommandModel.get(j).name) {
//                        recommandModel.move(j, i + 1, 1)
//                        break
//                    }
//            }
//        }
//    }
}

