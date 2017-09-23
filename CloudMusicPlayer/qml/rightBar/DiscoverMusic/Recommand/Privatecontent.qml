import QtQuick 2.7
import '../../../others/help.js' as ScriptHelper
import DataRequest 1.0

// 独家放送模块
Item {
    width: parent.width
    height: section.height + row.height
    SectionDelegate {
        id: section
        text: '独家放送'
    }

    Flow {
        id: row
        width: parent.width
        anchors.top: section.bottom
        anchors.topMargin: 10

        spacing: 20
        Repeater {
            id: repeater
            model: listmodel
            delegate: __delegate
        }
    }

    ListModel {
        id: listmodel
    }

    Component {
        id: __delegate
        Item {
            id: wrapper

            Column {
                Image {
                    width: parent.width
                    height: width / 1.6
                    source: picUrl
                }
                Text {
                    width: parent.width
                    text: name
                    wrapMode: Text.Wrap
                }
                anchors.fill: parent
                spacing: 10
            }
            width: (row.width - row.spacing * (listmodel.count - 1)) / listmodel.count
            height: width / 1.4
        }

    }

//    Component.onCompleted: ScriptHelper.readFile('file:///C:/Users/Administrator/Desktop/CloudMusic/独家放送.json', listmodel)

    DataRequest {
        id: request
        onFinished: ScriptHelper.route(json, pathName, listmodel)
    }

    Component.onCompleted: request.get('/personalized/privatecontent')
}
