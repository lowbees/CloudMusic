import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import '../../others' as Other

//import DataRequest 1.0

ListView {
    id: discoverMusic
    anchors.fill: parent
    boundsBehavior: Flickable.StopAtBounds

    function changeTabPage(index) {
//        if (index === 0)
//            loader.source = './Recommand/Recommand.qml'
    }

    // 栏目
    header: Item {
        width: parent.width
        height: 50
        TabBar {
            id: tabBar
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            background: Item {

            }

            onCurrentIndexChanged: changeTabPage(currentIndex)
            Repeater {
                model: ['个性推荐', '歌单', '主播电台', '排行榜', '歌手', '最新音乐']
                delegate: Other.TabButton {
                    text: modelData
                    font.pixelSize: 14
                    indicatorVisible: (tabBar.currentIndex === index)
                    color: (tabBar.currentIndex === index || hovered) ? '#c62f2f' :  '#333'
                }

            }
        }

        Other.Line {
            anchors.top: tabBar.bottom
            width: parent.width
        }
    }


    ListModel {
        id: recommandModel
        ListElement { sourceUrl: './Recommand/Banner.qml'; name: 'Banner' }
        ListElement { sourceUrl: './Recommand/Personalized.qml'; name: '推荐歌单' }
        ListElement { sourceUrl: './Recommand/Privatecontent.qml'; name: '独家放送' }
        ListElement { sourceUrl: './Recommand/NewSong.qml'; name: '最新音乐' }
        ListElement { sourceUrl: './Recommand/MV.qml'; name: '推荐MV' }
        ListElement { sourceUrl: './Recommand/RadioDJ.qml'; name: '主播电台' }
        ListElement { sourceUrl: './Recommand/CustomLayout.qml'; name: 'ChangeLayout' }
    }

    spacing: 60
    model: recommandModel
    delegate: Item {
        width: discoverMusic.width
        height:  loader.height
        Loader {
            id: loader
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            source: sourceUrl
        }
    }

    ScrollBar.vertical: ScrollBar { anchors.right: parent.right}
}
