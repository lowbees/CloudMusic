import QtQuick 2.7
//import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4 as QC14
import QtQuick.Layouts 1.1

import 'qml/titleBar' as TitleBar
import 'qml/bottomBar' as BottomBar
import 'qml/leftBar' as LeftBar
import 'qml/rightBar' as RightBar
import 'qml/others/help.js' as ScriptHelper
import FramelessWindowHelper 1.0
import QtAV 1.6
ApplicationWindow {
    id: rootWindow
    title: '网易云音乐'
    visible: true
    width: 1000
    height: 600
    minimumWidth: 1022
    minimumHeight: 670
    color: '#fafafa'

    property int currentIndexPlay: -1

    // mode 0为列表循环
    // mode 1为单曲循环
    // mode 2为随机播放
    // mode 3为顺序播放
    property int playMode: 0
    readonly property int musicCount: playlist ? playlist.count : 0
    property variant playlist


    // 提供给左下角的音乐信息
    signal musicInfo(variant info)
    signal playbackState(int state)

    // 播放暂停
    function playPause() {
        if (player.playbackState === MediaPlayer.PlayingState)
            player.pause()
        else
            player.play()
    }

    // 获取下一首应该要播放的index
    function getNextIndex() {
        if (!playlist)
            return -1
        if (playMode === 0)
            return ScriptHelper.playList(currentIndexPlay, musicCount)
        else if (playMode === 1)
            return currentIndexPlay
        else if (playMode === 2)
            return ScriptHelper.playRandom(musicCount)
        else
            return ScriptHelper.playInorder(currentIndexPlay, musicCount)
    }

    // 播放当前下标所指示的音乐
    function playNewMusic() {
        if (playlist && musicCount > 0) {
            if (currentIndexPlay >= 0 && currentIndexPlay < musicCount) {
                player.stop()
                player.source = playlist.get(currentIndexPlay).url
                player.play()
            }
        }
    }

    // 播放下一首
    function playNext() {
        if (playlist && musicCount > 0) {
            currentIndexPlay = (currentIndexPlay + 1) % musicCount
            playNewMusic()
        }
    }

    // 播放上一首
    function playPrev() {
        if (playlist && musicCount > 0) {
            currentIndexPlay = (currentIndexPlay - 1) < 0 ?
                        musicCount - 1 :  currentIndexPlay - 1
            playNewMusic()
        }
    }

    onCurrentIndexPlayChanged: {
        if (playlist && currentIndexPlay < playlist.count)
            musicInfo(playlist.get(currentIndexPlay))
    }

    flags: Qt.FramelessWindowHint | Qt.Window
    header: TitleBar.TitleBar {
    }

    FramelessWindowHelper {

    }

    MediaPlayer {
        id: player
        loops: playMode === 1
        onStatusChanged: {
            if (status === MediaPlayer.EndOfMedia) {
                currentIndexPlay = getNextIndex()
                playNewMusic()
            }
        }
        onPlaybackStateChanged: rootWindow.playbackState(playbackState)
    }

    FontLoader {
        source: 'file:///' + pathGetter.getCurrentPath() + '/font/icomoon.ttf'
    }
//    FontLoader {
//        source: './font/icomoon.ttf'
//    }

    QC14.SplitView {
        id: splitView
        anchors.fill: parent
        orientation: Qt.Horizontal
        handleDelegate: Rectangle {
            width: 1
            height: splitView.height
            color: '#e1e1e2'
            MouseArea {
                anchors.fill: parent
                anchors.margins: -2
                acceptedButtons: Qt.NoButton
                cursorShape: splitView.orientation == Qt.Horizontal ? Qt.SizeHorCursor : Qt.SizeVerCursor
            }
        }

        LeftBar.LeftBar {
//            Layout.preferredWidth: 200
            width: 200
            Layout.minimumWidth: 200
            Layout.fillHeight: true
            Component.onCompleted: {
                musicInfo.connect(updateMusicInfo)
                currentIndexPlayChanged.connect(updateCurrentIndex)
                currentPage.connect(changePage)
            }
        }

//        RightBar.RightBar {
//            Layout.minimumWidth: 820
//            Layout.fillWidth: true
//            Layout.fillHeight: true
//        }

        Loader {
            id: rightLoader
            Layout.minimumWidth: 820
            Layout.fillHeight: true
            Layout.fillWidth: true
//            source: 'qrc:/qml/rightBar/LocalMusic.qml'
            source: './qml/rightBar/LocalMusic.qml'
        }
    }

    function changePage(page) {
        console.log(page)
        if (page === 'LocalMusic.qml')
            rightLoader.source = 'qrc:/qml/rightBar/LocalMusic.qml'
    }



//    RowLayout {
//        id: mainLayout

//    }

    footer: BottomBar.BottomBar {
        Component.onCompleted: {
            player.durationChanged.connect(updateProgress)
            player.positionChanged.connect(updateProgress)
            rootWindow.playbackState.connect(updatePlayState)
        }
    }
}
