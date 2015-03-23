import QtQuick 2.0

Item{
    Userlist{
        id:astschview
        isDeletable: true
        visible: true
        anchors{
            top: btnNewUser.bottom
            topMargin: 5
            left: parent.left
            leftMargin: 5
            right: parent.right
            rightMargin: 5
            bottom: parent.bottom
            bottomMargin: 85
        }

        onSelected: {
            update.id =    id;
            update.roleId =    roleId;
            update.username =    username;
            update.realname =    realname;
            update.rfid =    rfid;
            update.timeSaldo =    timeSaldo;

        }

        onClicked: {
            update.id =    UserlistModel[astschview.currentRow].id;
            update.roleId =    UserlistModel[astschview.currentRow].roleId;
            update.timeSaldo =   UserlistModel[astschview.currentRow].timeSaldo;
            update.username =    UserlistModel[astschview.currentRow].username;
            update.realname =    UserlistModel[astschview.currentRow].realname;
            update.rfid =    UserlistModel[astschview.currentRow].rfid;
        }

        onDeleted: {
            Services.deleteUser(id);
            Services.getUserListData("beat");
        }
        Component.onCompleted: {
            console.log("UserAdmin:userlist ");
        }

    }

    UpdateUserlist{
        id: update
        visible: false
        anchors{
            top: astschview.bottom
            topMargin: 10
            bottom: parent.bottom
            bottomMargin: 10
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }
        onUpdate: {
            //doUpdate(txtBoxUsername.text);
            doUpdate(update.username)
            Services.getUserListData("beat");
        }
        Component.onCompleted: {
            console.log("UserAdmin:updateUserlist ");
        }

    }

    Rectangle{
        id:btnNewUser
        width: 100
        height: 20
        radius: 3
        Text{
            text: "Add New User"
            anchors.centerIn: parent
        }
        anchors{
            top: parent.top
            left: parent.left
            topMargin: 10
            leftMargin: 10
            //verticalCenter: parent.verticalCenter
        }
        gradient:Gradient{
            GradientStop{position: 0.0; color: "white";}
            GradientStop{position: 0.3; color: "lightgrey";}
            GradientStop{position: 0.7; color: "grey";}
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                //                Services.getUserListData(cmbast.text);
                Services.insertUser(2,"username","realname","rfid",100);
                Services.getUserListData("beat");
                astschview.visible = true;
                update.visible = true;
            }
        }
    }
    Component.onCompleted: {
        console.log("UserAdmin:atEnd");

        Services.getUserListData("beat");
        astschview.visible = true;
        update.visible = true;
    }
}
/*
MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: {
        console.log("Click")
        if (mouse.button == Qt.LeftButton)
        {
            console.log("Left")
        }
        else if (mouse.button == Qt.RightButton)
        {
            console.log("Right")
        }
    }
}
*/
