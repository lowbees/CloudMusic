import QtQuick 2.7
import QtQuick.Layouts 1.1

import '../../../others/help.js' as ScriptHelper
import DataRequest 1.0
Item {
    width: parent.width
    height: section.height + grid.height

    SectionDelegate {
        id: section
    }

    Grid {
        width: parent.width
        anchors.top: section.bottom
        anchors.topMargin: 10

        id: grid
        rows: 2
        columns: 5

        rowSpacing: 40
        columnSpacing: 20

        ListModel {
            id: listmodel
        }

        Item {
            id: wrapper

            property string today: {
                var today = new Date()
                var d = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
                return d[today.getDay()]

            }

            property string day: new Date().getDate()

            width: (grid.width- (grid.columns - 1) * grid.columnSpacing) / grid.columns
            height: width * 1.2

            Column {
                anchors.fill: parent
                spacing: 10

                Rectangle {
                    width: parent.width
                    height: width
                    color: 'white'
                    border.width: 1
                    border.color: '#e5e5e5'

                    Column {
                        anchors.centerIn: parent

                        Text {
                            text: wrapper.today
                            font.pointSize: 16
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: wrapper.day
                            color: '#c62f2f'
                            font.pointSize: 80
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                Text {
                    text: '每日歌曲推荐'
                    font.pointSize: 10
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
        Repeater {
            model: listmodel

            delegate: __delegate
        }


        Component {
            id: __delegate
            Item {
                id: wrapper
                width: (grid.width - (grid.columns - 1) * grid.columnSpacing) / grid.columns
                height: width * 1.2

                Column {
                    anchors.fill: parent
                    spacing: 10
                    Image {
                        width: parent.width
                        height: width
                        source: picUrl
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                    Text {
                        id: nameText
                        text: name
                        width: parent.width
                        wrapMode: Text.Wrap
                        font.pointSize: 10

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
        }

        //Component.onCompleted: ScriptHelper.readFile('file:///C:/Users/Administrator/Desktop/CloudMusic/推荐歌单.json', listmodel)
    }


    DataRequest {
        id: request
        onFinished: ScriptHelper.route(json, pathName, listmodel)
    }

    Component.onCompleted: request.get('/personalized')
}
