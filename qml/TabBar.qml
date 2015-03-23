import QtQuick 2.0

Item {
    Rectangle{
        id: tab1
        width: 150
        height: 30
        color: "gold"
        radius: 5
        Text{
            text: "Activity Log"
            anchors{
                top: parent.top
                topMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
        }
        anchors{
            top: parent.top
            left: parent.left
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                parent.color = "gold";
                tab2.color = "lightgrey";
                loadcom.source = "ActivityLog.qml"
            }
        }
    }
    Rectangle{
        id: tab2
        width: 150
        height: 30
        color: "lightgrey"
        radius: 5
        Text{
            text: "User Admin"
            anchors{
                top: parent.top
                topMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
        }
        anchors{
            top: parent.top
            left: tab1.right
            leftMargin: 5
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                parent.color = "gold";
                tab1.color = "lightgrey";
                loadcom.source = "UserAdmin.qml"
            }
        }
    }
    Rectangle{
        anchors{
            top: parent.top
            topMargin: 20
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        radius: 5
        gradient:Gradient{
            GradientStop{position: 0.0; color: "lightgrey"}
            GradientStop{position: 0.1; color: "white"}
            GradientStop{position: 0.9; color: "lightgrey"}
        }
        border.color: "grey"
        Loader{
            id: loadcom;
            source: "ActivityLog.qml"
            anchors.fill: parent
        }
    }
}
