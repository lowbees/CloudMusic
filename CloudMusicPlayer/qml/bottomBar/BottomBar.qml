import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

import "../others" as Other
import '../others/help.js' as ScriptHelper
//import '../others/help.js' as SriptHelper
Rectangle {
    height: 50
    color: '#f6f6f8'

    Other.Line {
        anchors.top: parent.top
        width: parent.width
    }

    function updatePlayState(playState) {

        if (playState === 1) /// playing state
            playButton.text = '\ued04'
        else
            playButton.text = '\ued03'
    }


    function updateProgress() {
        var duration = ScriptHelper.formatTime(player.duration)
        var position = ScriptHelper.formatTime(player.position)
        playTimeText.text = position
        totalTime.text = duration
        if (!playSlider.pressed)
            playSlider.value = (player.position / player.duration)

    }


    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 30
        spacing: 30

        Other.FontButton {
            text: '\ued06'
            normalColor: '#e83c3c'
            hoverColor: '#d33030'
        }
        Other.FontButton {
            id: playButton
            text: '\ued03'
            normalColor: '#e83c3c'
            hoverColor: '#d33030'
            font.pointSize: 24
            onClicked: rootWindow.playPause()
        }
        Other.FontButton {
            text: '\ued07'
            normalColor: '#e83c3c'
            hoverColor: '#d33030'
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                id: playTimeText
                text: '00:00'
                Layout.alignment: Qt.AlignVCenter
            }

            Other.Slider {
                id: playSlider
                Layout.alignment: Qt.AlignVCenter
                onPositionChanged: {
                    if (player.hasAudio && pressed) {
                        player.seek(position * player.duration)
                        updateProgress()
                    }
                }

                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
            }

            Text {
                id: totalTime
                text: '00:00'
                Layout.alignment: Qt.AlignVCenter
            }

        }

        RowLayout {
            Layout.preferredWidth: 130
            Layout.fillHeight: true
            spacing: 0
            Other.FontButton {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 24
                property real dirtVol: player.volume
                text: ScriptHelper.fuzzyCompare(player.volume, 0.0) ? '\uef1f' : '\uef1e'
                font.pointSize: 10
                normalColor: '#666'
                hoverColor: '#444'
                onClicked: {
                    if (ScriptHelper.fuzzyCompare(player.volume, 0.0))
                        player.volume = dirtVol
                    else {
                        dirtVol = player.volume
                        player.volume = 0.0
                    }

                }
            }
            Other.Slider {
                id: volumnSlider
                Layout.alignment: Qt.AlignVCenter
                value: player.volume
                onPositionChanged: player.volume = position
            }
        }

        Other.FontButton {
            text: {
                if (rootWindow.playMode === 0) // 列表循环
                    return '\uf922'
                else if (rootWindow.playMode === 1) // 单曲循环
                    return '\uf923'
                else if (rootWindow.playMode === 2) // 随机播放
                    return '\ufbef'
                else return '\uf904'
            }
            font.pointSize: {
                if (text === '\ufbef')
                    return 11
                else
                    return 14
            }

            onClicked: rootWindow.playMode = (rootWindow.playMode + 1) % 4
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }


}
