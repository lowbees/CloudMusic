import QtQuick 2.7
import '../../../others/help.js' as ScriptHelper
import DataRequest 1.0

Item {
    width: parent.width
    height: section.height + grid.height
    SectionDelegate {
        id: section
        text: '最新音乐'
    }

    Grid {
        id: grid
        anchors.top: section.bottom
        anchors.topMargin: 10
        width: parent.width

        rows: 5
        columns: 2

        flow: Grid.TopToBottom

        Repeater {
            model: listmodel
            delegate: __delegate
        }
    }

    ListModel {
        id: listmodel
    }

    Component {
        id: __delegate
        Rectangle {
            id: wrapper
            border.width: 1
            border.color: '#ededed'
            color: {
                if (index >=5 && index % 2 === 0)
                    return '#f5f5f7'
                else if (index < 5 && index % 2 !== 0)
                    return '#f5f5f7'
                return '#fafafa'
            }
                //(index + 1) % 2 == 0 ? '#f5f5f7' : '#fafafa'
            width: grid.width / 2
            height: 60

            Row {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10
                Text { text: (index + 1) < 10 ? '0' + (index + 1) : (index + 1); anchors.verticalCenter: parent.verticalCenter }
                Image {
                    width: 40
                    height: 40
                    source: picUrl
                }

                Column {
                    height: parent.height
                    spacing: 6
                    Text { text: name}
                    Text { text: artist}
                }
            }
        }
    }

//    Component.onCompleted: ScriptHelper.readFile('file:///C:/Users/Administrator/Desktop/CloudMusic/最新音乐.json', listmodel)

    DataRequest {
        id: request
        onFinished: ScriptHelper.route(json, pathName, listmodel)
    }

    Component.onCompleted: request.get('/personalized/newsong')
}
