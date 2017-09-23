import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Popup {
    id: popup
//    modal: true
    dim: false

    property variant model

    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        id: popupBackground
        implicitWidth: 390
        implicitHeight: 490
        color: 'transparent'
    }
    Rectangle {
        anchors.fill: parent
        color: '#fafafa'
        id: backgroundItem

        // title
        Item {
            id: popupTitle
            width: parent.width
            height: 50

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.SizeAllCursor
                property point pos: '0,0'
                onPressed: pos = Qt.point(mouse.x, mouse.y)
                onPositionChanged: {
                    popup.x += mouse.x - pos.x
                    popup.y  += mouse.y - pos.y
                }
            }
            Text {
                text: '调整栏目顺序'
                font.pointSize: 10
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: '\uf750'
                font.family: 'icomoon'
                font.pointSize: 14
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: popup.close()
                }
            }



            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: '#e1e1e2'
            }

        }

        Row {
            id: row
            anchors.top: popupTitle.bottom
            anchors.left: parent.left
            anchors.leftMargin: 30
            width: parent.width
            height: 60
            spacing: 6
            Text { text: '\ufacb'; font.family: 'icomoon'; font.pointSize: 10; anchors.verticalCenter: parent.verticalCenter;  }
            Text { text: '想调整首页栏目顺序？按住右边的按钮拖动即可'; anchors.verticalCenter: parent.verticalCenter }
        }

        ListView {
            id: listview
            anchors.top: row.bottom
            anchors.topMargin: 10
            clip: true
            width: parent.width
            height: 390
            boundsBehavior: ListView.StopAtBounds

            displaced: Transition {
                NumberAnimation { property: 'y'; easing.type: Easing.OutQuad }
            }

            model: popup.model
            delegate: __delegate
        }


    }

    DropShadow {
        source: backgroundItem
        anchors.fill: backgroundItem
        horizontalOffset: -3
        radius: 8.0
        samples: 17
        color: "#80000000"
    }
    DropShadow {
        source: backgroundItem
        anchors.fill: backgroundItem
        horizontalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
    }
    Component {
        id: __delegate
        MouseArea {
            id: wrapper
            width: listview.width
            height: 50
            property bool hovered: false
            property int visualIndex: index

            drag.target: rect
            hoverEnabled: true
            onEntered: hovered = true
            onExited: hovered = false


            Rectangle {
                id: rect
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                color: wrapper.pressed ? 'white' : wrapper.hovered ? '#f0f0f0' :  '#fafafa'

                Drag.active: wrapper.drag.active
                Drag.source: wrapper
                Drag.hotSpot.x: 36
                Drag.hotSpot.y: 36

                states: [
                    State {
                        when: rect.Drag.active
                        ParentChange { target: rect; parent: listview }
                        AnchorChanges { target: rect; anchors.top: undefined; anchors.bottom: undefined }
                    }

                ]


                Item {
                    width: 300
                    height: parent.height
                    Text { text: name; anchors.verticalCenter: parent.verticalCenter }
                    Rectangle { width: parent.width; height: 1; color: '#f0f0f2'; anchors.bottom: parent.bottom }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }


            DropArea {
                anchors.fill: parent
                anchors.margins: 15
                onEntered: popup.model.move(drag.source.visualIndex, wrapper.visualIndex, 1)
            }
        }
    }

}




