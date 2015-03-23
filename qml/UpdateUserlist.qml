import QtQuick 2.0

Item{
    id: root
    property int userId: -1
    property alias timeSaldo: txtBoxTimeSaldo.text
    property alias username: txtBoxUsername.text
    property alias realname: txtBoxRealname.text
    property alias rfid: txtBoxRfid.text
    property alias id: txtBoxId.text
    property alias roleId: txtBoxRoleId.text
    signal update



    function doUpdate(username){
        if(id === -1)
        {
            errMsg.color = "red";
            errMsg.text = "You have to choose one item from the list "+username+id;
            errMsg.visible = true;
        }
        else if(username.trim() === "" || realname.trim() ===""
                || rfid.trim() === "" || timeSaldo.trim() === "")
        {
            errMsg.color = "red";
            errMsg.text = "All field must be filled";
            errMsg.visible = true;
        }
        else{
            var result = Services.updateUser(id,roleId,username,realname,rfid,timeSaldo);
            if(result){
                errMsg.color = "green";
                errMsg.text = "User updated successfully";
                errMsg.visible = true;
                Services.getUserData(username);
            }else
            {
                errMsg.color = "red";
                errMsg.text = "Failed to update user ";
                errMsg.visible = true;
            }
        }
    }


    Rectangle {
        id: con
        width: parent.width
        height: parent.height
        border.color: "grey"
        color: "lightgrey"
        Item{
            width: parent.width-20
            height: parent.height
            anchors.centerIn: con

            TextBox{
                id: txtBoxId
                visible: false
            }

            Text{
                id: txtUsername
                text: "Username"
                color: "grey"
                anchors{
                    top: parent.top
                    horizontalCenter: txtBoxUsername.horizontalCenter
                }
            }
            TextBox{
                id: txtBoxUsername
                height: 20
                width: parent.width/1.9
                maxLength: 100
                anchors{
                    top: txtUsername.bottom
                    topMargin: 3
                    left: parent.left
                }
            }
            Text{
                id: txtRealname
                text: "Realname"
                color: "grey"
                anchors{
                    top: parent.top
                    horizontalCenter: txtBoxRealname.horizontalCenter
                }
            }
            TextBox{
                id: txtBoxRealname
                width: parent.width/6
                maxLength: 20
                height: 20
                anchors{
                    top: txtRealname.bottom
                    topMargin: 3
                    left: txtBoxUsername.right
                    leftMargin: 3
                }
            }
            Text{
                id: txtRfid
                text: "RFID"
                color: "grey"
                anchors{
                    top: parent.top
                    horizontalCenter: txtBoxRfid.horizontalCenter
                }
            }
            TextBox{
                id: txtBoxRfid
                width: parent.width/6
                height: 20
                maxLength: 20
                anchors{
                    top: txtRfid.bottom
                    topMargin: 3
                    left: txtBoxRealname.right
                    leftMargin: 3
                }
            }
            Text{
                id: txtTimeSaldo
                text: "Time Saldo"
                color: "grey"
                anchors{
                    top: parent.top
                    horizontalCenter: txtBoxTimeSaldo.horizontalCenter
                }
            }
            TextBox{
                id: txtBoxTimeSaldo
                width: parent.width/8
                height: 20
                maxLength: 20
                isDate: true
                anchors{
                    top: txtTimeSaldo.bottom
                    topMargin: 3
                    left: txtBoxRfid.right
                    leftMargin: 3
                }
            }
            Text{
                visible: false
                id: txtRoleId
                text: "Time Saldo"
                color: "grey"
                anchors{
                    top: parent.top
                    horizontalCenter: txtBoxRoleId.horizontalCenter
                }
            }
            TextBox{
                visible: false
                id: txtBoxRoleId
                width: parent.width/8
                height: 20
                maxLength: 20
                isDate: true
                anchors{
                    top: txtRoleId.bottom
                    topMargin: 3
                    left: txtTimeSaldo.right
                    leftMargin: 3
                }
            }
        }
        Rectangle{
            id: btnUpdate
            width: parent.width/10
            height: 20
            radius: 3
            Text{
                anchors.centerIn: parent
                text: "Update"
            }
            gradient:Gradient{
                GradientStop{position: 0.0; color: "white";}
                GradientStop{position: 0.3; color: "lightgrey";}
                GradientStop{position: 0.7; color: "grey";}
            }
            anchors{
                bottom: parent.bottom
                bottomMargin: 5
                left: parent.left
                leftMargin: 30
            }
            MouseArea{
                anchors.fill: parent
                onClicked: root.update()
            }
        }

        Rectangle{
            id: btnDelete
            width: parent.width/10
            height: 20
            radius: 3
            Text{
                anchors.centerIn: parent
                text: "Delete"
            }
            gradient:Gradient{
                GradientStop{position: 0.0; color: "white";}
                GradientStop{position: 0.3; color: "lightgrey";}
                GradientStop{position: 0.7; color: "grey";}
            }
            anchors{
                bottom: parent.bottom
                bottomMargin: 5
                right: parent.right
                rightMargin: 30
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    Services.deleteUser(id);
                    Services.getUserListData("beat");
                }
            }
        }


        Text{
            id: errMsg
            color: "green"
            visible: false
            anchors{
                left: btnUpdate.right
                leftMargin: 5
                verticalCenter: btnUpdate.verticalCenter
            }
        }
    }
    Component.onCompleted: {
        console.log("UpdateUserlist:root ");
    }

}
