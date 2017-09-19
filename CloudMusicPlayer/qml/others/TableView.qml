import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TableView {
    id: root
    implicitWidth: 600
    implicitHeight: 600

    property color normalColor: '#fafafa'
    property color hoverColor: '#ecedee'
    property color pressColor: '#e4e4e6'
    property color alternateColor: alternatingRowColors ? '#f5f5f7' : normalColor

    rowDelegate: __rowdelegate


    onRowCountChanged: if (rowCount > 0) currentRow = 0

    Component {
        id: __rowdelegate
        Rectangle {
            id: wrapper
            width: root.width
            height: 30
            color: {
                if (root.currentRow === styleData.row) // currentRow
                    return pressColor
                else if (mousearea.containsMouse) // hoverColor
                    return hoverColor
                else if (styleData.row % 2 !== 0) // alternateColor
                    return alternateColor
                else
                    return normalColor
            }

            MouseArea {
                id: mousearea
                anchors.fill: parent
                hoverEnabled: true
                onDoubleClicked: root.doubleClicked(styleData.row)
                onClicked: { root.currentRow = styleData.row; root.clicked(styleData.row)}

            }

        }
    }
}
