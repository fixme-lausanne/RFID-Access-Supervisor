import QtQuick 2.0

Rectangle{
    width: 15
    height: 15
    anchors{
        right: parent.right
        rightMargin: 5
        top: parent.top
        topMargin: 5
    }
    border.color: "red"
    color: "tomato"
    radius: 3
    smooth: true
    Text{
        text: "x"
        color: "white"
        font{bold: true}
        anchors.centerIn: parent
    }
    MouseArea{
        anchors.fill: parent
        onClicked: Qt.quit();
    }
}
