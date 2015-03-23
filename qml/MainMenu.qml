import QtQuick 2.0

Rectangle {
    width: 780
    height: 535
    border.width: 3
    border.color: "grey"
    gradient:Gradient{
        GradientStop{position: 0.05; color: "lightgrey"}
        GradientStop{position: 0.1; color: "white"}
        GradientStop{position: 0.9; color: "lightgrey"}
        GradientStop{position: 0.95; color: "grey"}
    }

    Logo{
        id: logo
        anchors{
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 30
        }
    }

    Text{
        text: "Assistant Schedule"
        color: "darkblue"
        font{
            pixelSize: 30
            bold: true
            family: "Bauhaus 93"
        }
        anchors{
            verticalCenter: logo.verticalCenter
            left: logo.right
            leftMargin: 10
        }
        style: Text.Raised
    }

    Text{
        id: welcome
        text: "Welcome, "+Session.name+" | "
        color: "blue"
        font{
            pixelSize: 15
            bold: true
            family: "Arial"
        }
        anchors{
            bottom: logo.bottom
            left: logo.right
            leftMargin: 10
        }
        //style: Text.Raised
    }

    Text{
        id:signout
        text: "Sign Out"
        color: "blue"
        font{
            pixelSize: 15
            bold: true
            family: "Arial"
        }
        anchors{
            bottom: logo.bottom
            left: welcome.right
        }
        //style: Text.Raised
        MouseArea{
            anchors.fill: parent
            onClicked: container.state = "Login"
            hoverEnabled: true
            onEntered: {
                signout.color = "gold";
            }
            onExited: {
                signout.color = "blue";
            }
        }
    }

    Userlist{
        anchors{
            top: logo.bottom
            topMargin: 10
            bottom: parent.bottom
            bottomMargin: 10
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }
    }
    DragBox{}
    CloseButton{}
    Component.onCompleted: Services.getUserData(Session.username);
}
