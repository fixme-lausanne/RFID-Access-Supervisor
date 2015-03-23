import QtQuick 2.0

Item{
    id: root
    property alias text: combotext.text
    property variant mod

    Rectangle {
        id: combo
        width: parent.width
        height: parent.height
        color: "lightgrey"
        Text{
            id: combotext
            anchors{
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
        }
        Rectangle{
            width: parent.width/4
            height: parent.height
            color: "grey"
            radius: 3
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(content.model === emptymod){
                        root.z = 1;
                        content.model = mod;
                    }
                    else {
                        root.z = 0;
                        content.model = emptymod;
                    }

                }
            }
        }
        border.color: "grey"
        radius: 3
    }
    ListView{
        id: content
        anchors{
            top: combo.bottom
            left: combo.left
            right: combo.right
        }
        height: content.count>0?contentHeight:0
        ListModel{
            id: emptymod
        }
        clip: true
        model: emptymod
        boundsBehavior: Flickable.StopAtBounds
        delegate:Rectangle{
            width: parent.width
            height: 20
            color: "lightgrey"
            Text{
                text: modelData
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.z = 0;
                    combotext.text = modelData;
                    content.model = emptymod;
                }
                onEntered: parent.color = "gold"
                onExited: parent.color = "lightgrey"
            }
        }
    }
}


