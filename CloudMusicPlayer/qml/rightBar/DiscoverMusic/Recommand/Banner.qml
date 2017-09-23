
import QtQuick 2.7
import QtQuick.Controls 2.1
import '../../../others/help.js' as ScriptHelper
import DataRequest 1.0
Item {
    width: parent.width

    height: 220
    Item {
        id: wrapper
        width: parent.width
        implicitHeight: 200

        property alias count: pathView.count
        property alias currentIndex: pathView.currentIndex
        property alias currentItem: pathView.currentItem
        property alias dragging: pathView.dragging

        // visibleItemCount must be an odd number
        property int visibleItemCount: 1
//        property variant model
//        property Component delegate


        PathView {
            id: pathView
            anchors.fill: parent

            cacheItemCount: count - 1
            dragMargin: height /2

            model: listmodel
            delegate: __delegate
            path: Path {
                startX: -pathView.width / 2
                startY: pathView.height / 2

                PathLine {
                    x: pathView.pathItemCount * pathView.width - pathView.width / 2
                    y: pathView.height / 2
                }
            }

            pathItemCount: wrapper.visibleItemCount + 1
            // make currently selected always in the middle of path
            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5
            clip: true
        }
    }

    ListModel {
        id: listmodel
    }

    Component {
        id: __delegate
        Item {
            width: wrapper.width
            height: wrapper.height
            Image {
                anchors.fill: parent
                source: picUrl
            }
            Rectangle {
                height: titleRect.height
                width: height
                radius: height / 2
                color: titleColor
                anchors.top: titleRect.top
                anchors.right: titleRect.left
                anchors.rightMargin: -height / 2
            }

            Rectangle {
                id: titleRect
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                width: title.implicitWidth
                height: title.implicitHeight
                color: titleColor
                Text {
                    id: title
                    text: typeTitle
                    padding: 10
                    color: 'white'
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Qt.openUrlExternally(picUrl)
            }
        }

    }

    PageIndicator {
        id: indicator
        count: pathView.count
        currentIndex: pathView.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Timer {
        id: timer
        running: listmodel.count > 0
        repeat: true
        interval: 5000
        onTriggered: pathView.currentIndex = (pathView.currentIndex + 1) % pathView.count
    }


//    Component.onCompleted: ScriptHelper.readFile('file:///C:/Users/Administrator/Desktop/CloudMusic/banner.json', listmodel)

    DataRequest {
        id: request
        onFinished: ScriptHelper.route(json, pathName, listmodel)
    }

    Component.onCompleted: request.get('/banner')
}
