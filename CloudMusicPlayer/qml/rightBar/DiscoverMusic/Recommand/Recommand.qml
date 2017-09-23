import QtQuick 2.7
import QtQuick.Controls 2.1
import '../../../others' as Other

Column {
    id: column

    spacing: 30
//    anchors.left: parent.left
//    anchors.right: parent.right
    anchors.fill: parent
    anchors.leftMargin: 20
    anchors.rightMargin: 20

    ListModel {
        id: recommandModel
        ListElement { sourceUrl: 'Banner.qml'; name: 'Banner' }
        ListElement { sourceUrl: 'Personalized.qml'; name: '推荐歌单' }
        ListElement { sourceUrl: 'Privatecontent.qml'; name: '独家放送' }
        ListElement { sourceUrl: 'NewSong.qml'; name: '最新音乐' }
        ListElement { sourceUrl: 'MV.qml'; name: '推荐MV' }
        ListElement { sourceUrl: 'RadioDJ.qml'; name: '主播电台' }
    }

    ListModel {
        id: dirtyModel
        ListElement { sourceUrl: 'Personalized.qml'; name: '推荐歌单' }
        ListElement { sourceUrl: 'Privatecontent.qml'; name: '独家放送' }
        ListElement { sourceUrl: 'NewSong.qml'; name: '最新音乐' }
        ListElement { sourceUrl: 'MV.qml'; name: '推荐MV' }
        ListElement { sourceUrl: 'RadioDJ.qml'; name: '主播电台' }
    }

//    Repeater {
//        model: recommandModel
//        delegate: Loader {
//            width: column.width
//            source: sourceUrl
//            Component.onCompleted: console.log(index, height)
//        }
//    }

    ListView {
        width: parent.width
        height: parent.height
        model: recommandModel
        delegate: Loader {
            width: column.width
            source: sourceUrl
        }
        clip: true
        onContentHeightChanged: console.log(contentHeight)
    }



    //  根据个人喜好，更改顺序
    Item {
        height: 160
        width: parent.width

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
//                    for (var i = 1; i < recommandModel.count; ++i) {
//                        dirtyModel.append({
//                                       'sourceUrl': recommandModel.get(i).sourceUrl,
//                                       'name': recommandModel.get(i).name })
//                    }
                    popup.model = dirtyModel
                    popup.open()
                }
            }
        }
    }

    LDialog {
        id: popup
        x: (rootWindow.width - popup.width) / 4
        y: (rootWindow.height - header.height - footer.height - popup.height) / 2
        onClosed: {
            for (var i = 0; i < dirtyModel.count; ++i) {
                for (var j = i + 1; j < recommandModel.count; ++j)
                    if (dirtyModel.get(i).name === recommandModel.get(j).name) {
                        recommandModel.move(j, i + 1, 1)
                        break
                    }
            }
        }
    }

}
