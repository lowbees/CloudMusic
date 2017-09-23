import QtQuick 2.7
import '../../../others/help.js' as ScriptHelper
import '../../../others' as Other
import DataRequest 1.0
Item {
    width: parent.width
    height: section.height + grid.height
    SectionDelegate {
        id: section
        text: '主播电台'
    }

    Grid {
        id: grid

        anchors.top: section.bottom
        anchors.topMargin: 10
        rows: 3
        columns: 2
        columnSpacing: 50
        rowSpacing: 20

        width: parent.width

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
            width: (grid.width - grid.columnSpacing * (grid.columns - 1)) / grid.columns
            height: 90

            Other.Line {
                anchors.bottom: parent.bottom
                width: parent.width
                visible: index < grid.rows * grid.columns - grid.columns
            }

            Image {
                id: img
                width: 80
                height: 80
                source: picUrl
            }

            Column {
                id: column
                anchors.left: img.right
                anchors.leftMargin: 20
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 20

                Text { text: name; elide: Text.ElideRight ; width: parent.width }
                Text { text: brand; elide: Text.ElideRight ; width: parent.width }
            }
        }
    }
//    Component.onCompleted: ScriptHelper.readFile('file:///C:/Users/Administrator/Desktop/CloudMusic/推荐电台.json', listmodel)

    DataRequest {
        id: request
        onFinished: ScriptHelper.route(json, pathName, listmodel)
    }

    Component.onCompleted: request.get('/personalized/djprogram')
}
