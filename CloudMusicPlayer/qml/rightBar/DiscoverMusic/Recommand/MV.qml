import QtQuick 2.7
import '../../../others/help.js' as ScriptHelper
import DataRequest 1.0

Item {
    width: parent.width
    height: section.height + flow.height
    SectionDelegate {
        id: section
        text: '推荐MV'
    }

    Flow {
        id: flow

        anchors.top: section.bottom
        anchors.topMargin: 10
        spacing: 20
        clip: true
        width: parent.width
        height: 180
        Repeater {
            model: listmodel
            delegate:  __delegate
        }
    }

    ListModel {
        id: listmodel
    }
    Component {
        id: __delegate
        Item {
            id: wrapper
            property int prefercount: (flow.width - flow.spacing * (listmodel.count - 1)) / listmodel.count <= 260 ? 3 : 4
            //width: (flow.width - flow.spacing * (listmodel.count - 1)) / listmodel .count
            width: (flow.width - flow.spacing * (prefercount - 1)) / prefercount
            height: 180

            Column {
                id: column
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10
                Image {
                    width: parent.width
                    height: 140
                    source: picUrl
                }
                Text { text: name; width:parent.width; wrapMode: Text.Wrap }
            }
        }
    }
//    Component.onCompleted: ScriptHelper.readFile('file:///C:/Users/Administrator/Desktop/CloudMusic/推荐MV.json', listmodel)

    DataRequest {
        id: request
        onFinished: ScriptHelper.route(json, pathName, listmodel)
    }

    Component.onCompleted: request.get('/personalized/mv')
}
