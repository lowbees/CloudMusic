import QtQuick 2.7
import QtQuick.Controls 2.1

Slider {
    id: slider
    implicitHeight: 6
    property color backgroundColor: '#e6e6e8'
    property color progressColor: '#e83c3c'
    property color handleColor: 'white'
    property int handleWidth: 12
    property int handleHeight: 12
    background: Rectangle {
        x: slider.leftPadding
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 6
        width: slider.availableWidth
        height: implicitHeight
        radius: implicitHeight / 2
        color: backgroundColor

        Rectangle {
            width: slider.visualPosition * parent.width
            height: parent.height
            color: progressColor
            radius: parent.radius - 1
        }
    }

    handle: Rectangle {
        x: slider.leftPadding + slider.visualPosition *
           (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: handleWidth
        implicitHeight: handleHeight
        radius: implicitHeight / 2

        color: handleColor
        border.width: 1
        border.color: '#e1e1e2'

        Rectangle {
            anchors.centerIn: parent
            width: parent.width / 3
            height: parent.height / 3
            radius: height / 2

            color: '#e83c3c'
        }
    }
}
