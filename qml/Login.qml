import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: login
    width: 300
    height: 150
    radius: 3
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
            verticalCenter: parent.verticalCenter
        }
    }

    Text{
        id: username
        text: "Username"
        color: "grey"
        font{
            pixelSize: 12
            bold: true
        }
        anchors{
            top : logo.top
            left : logo.right
            leftMargin: 10
        }
    }

    TextBox{
        id: textUsername
        width: 150
        height: 20
        maxLength: 20
        anchors{
            left: logo.right
            leftMargin: 10
            top: username.bottom
            topMargin: 5
        }
        isFocus: true
    }

    Text{
        id: password
        text: "Password"
        color: "grey"
        font{
            pixelSize: 12
            bold: true
        }
        anchors{
            bottom : textPassword.top
            bottomMargin: 5
            left : logo.right
            leftMargin: 10
        }
    }

    TextBox{
        id: textPassword
        width: 150
        height: 20
        maxLength: 19
        anchors{
            left: logo.right
            leftMargin: 10
            bottom: logo.bottom
        }
        isPassword: true
        onEnter: {
            if(textPassword.text.trim()==="" || textUsername.text.trim()==="")
            {
                err.visible = true;
                err.text = "Username or password must be filled"
            }
            else if(Services.doLogin(textUsername.text,textPassword.text))
            {
                Session.username = textUsername.text;
                var userid = Services.getUserID(Session.username);
                if(Services.getUserRole(userid)==="RFID Admin")
                {
                    container.state = "AstSpv";
                }
                else
                {
                    container.state = "MainMenu";
                }
            }
            else
            {
                err.visible = true;
                err.text = "Wrong Username or password"
            }
        }
    }

    Text {
        id: err
        color: "red"
        visible: false
        anchors{
            top: textPassword.bottom
            topMargin: 5
            horizontalCenter: parent.horizontalCenter
        }
    }
    DragBox{}

    CloseButton{}
    border.color: "grey"
    Keys.onTabPressed: {
        if(textUsername.isFocus)textPassword.isFocus = true;
        else textUsername.isFocus = true;
    }
}
