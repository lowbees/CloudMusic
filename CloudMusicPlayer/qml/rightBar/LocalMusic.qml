import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4 as QC14
import QtQuick.Controls 2.1
import AudioData 1.0
import QtQuick.Dialogs 1.2
import '../others' as Other
import '../others/help.js' as Script

Flickable {
    id: root
    boundsBehavior: Flickable.StopAtBounds
    contentHeight: mainLayout.height
    contentWidth: width

    property url __lastDir: 'f:/Music'
    property int musicCount: 0

    signal currentMusic(string url)


    ScrollBar.vertical: ScrollBar { }

    ColumnLayout {
        id: mainLayout
        //        anchors.left: parent.left
        //        anchors.right: parent.right
        //        anchors.rightMargin: 10
        width: parent.width - 40
        Item {
            Layout.minimumHeight: 60
            Layout.fillWidth: true

            RowLayout {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottomMargin: 10
                anchors.leftMargin: 20
                Text {
                    text: '本地音乐'
                    font.pointSize: 18
                    color: '#333'
                    Layout.alignment: Qt.AlignBottom
                }
                Text {
                    text: musicCount + '首音乐,'
                    color: '#333'
                    Layout.alignment: Qt.AlignBottom
                }
                Text {
                    text: '选择目录'
                    color: '#0a63a8'
                    Layout.alignment: Qt.AlignBottom
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: fileDialog.open()
                    }
                }
                Item {
                    Layout.fillWidth: true
                }
            }

            Other.Line {
                width: parent.width
                anchors.bottom: parent.bottom
            }
        }
        Item {
            Layout.minimumHeight: 60
            Layout.fillWidth: true
        }

        Other.TableView {
            id: tableView

            onDoubleClicked: {
                if (row < dataModel.count) {
                    root.currentMusic(dataModel.get(row).url)
                    if (rootWindow.playlist !== dataModel)
                        rootWindow.playlist = dataModel
                    player.stop()
                    player.source = dataModel.get(row).url
                    player.play()
                    rootWindow.currentIndexPlay = row
                }
            }

            Layout.preferredHeight: tableView.rowCount * 30 + 30
            Layout.fillWidth: true
            model: dataModel
            frameVisible: false
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

            headerDelegate: Rectangle {
                implicitWidth: 150
                implicitHeight: 30
                color: '#fafafa'
                Other.Line {
                    anchors.top: parent.top
                    width: parent.width
                }

                Other.Line {
                    visible: styleData.column !== tableView.columnCount - 1
                    anchors.right: parent.right
                    width: 1
                    height: parent.height
                }

                Text {
                    text: styleData.value
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    color: '#333'
                }
                Other.Line {
                    anchors.bottom: parent.bottom
                    width: parent.width
                }
            }

            QC14.TableViewColumn {
                width: 50
                delegate: Item {
                    Text {
                        text: (styleData.row + 1) < 10 ?
                                  '0' + (styleData.row + 1) : (styleData.row + 1)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            QC14.TableViewColumn {
                role: 'title'
                title: '音乐标题'
                resizable: true
            }
            QC14.TableViewColumn {
                role: 'artist'
                title: '歌手'
            }
            QC14.TableViewColumn {
                role: 'album'
                title: '专辑'
            }
            QC14.TableViewColumn {
                role: 'duration'
                title: '时长'
            }
            QC14.TableViewColumn {
                role: 'size'
                title: '大小'
            }
        }
    }

    ListModel {
        id: dataModel
    }

    AudioData {
        id: audioData
        onParseFinished: {
            var data = JSON.parse(json)
            data = data['songs']
            root.musicCount = data.length
            for (var i = 0; i < data.length; ++i) {
                dataModel.append({
                                     'title': data[i].title,
                                     'artist': data[i].artist !== '' ? data[i].artist : '未知歌手',
                                     'album': data[i].album !== '' ? data[i].album : '未知专辑',
                                     'duration': Script.formatTime(data[i].duration, true),
                                     'size': Script.formatSize(data[i].size),
                                     'url': data[i].url,
                                     'picUrl': data[i].pic
                                 })
            }
        }
    }

    FileDialog {
        id: fileDialog
        //            selectFolder: true
        selectMultiple: true
        nameFilters: ["*.mp3"]
        folder: __lastDir
        onAccepted: {
            var lastfolder = folder.toString()
            __lastDir = lastfolder.slice(8)
            //                console.log(__lastDir)
            audioData.addFiles(fileUrls)

        }
    }



}
