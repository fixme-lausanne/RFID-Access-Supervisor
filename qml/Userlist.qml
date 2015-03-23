import QtQuick 2.0
import QtQuick.Controls 1.1


TableView {
    id:root
    property bool isDeletable: true
    signal selected(var id,var roleId, var username, var realname, var rfid,var timeSaldo)
    signal deleted(var id)
    clip: true

    anchors{
        topMargin: 30
        left: parent.left
        leftMargin: 5
        right: parent.right
        rightMargin: 5
    }
    width: parent.width
    height: parent.height-50

    // Row Delegate
    /*rowDelegate: Item {

                    height: 20 + 15
                    Rectangle {
                                anchors {
                                            left: parent.left
                                            right: parent.right
                                            verticalCenter: parent.verticalCenter
                                         }
                                height: parent.height
                                color: styleData.selected ? 'lightblue' : 'white'

                                }
                      }*/


    TableViewColumn {
        id: id
        role: "id"
        title: "access level"
        width: parent.width*0.1
        delegate:
            Button {
            text: "<level>"
            width: parent.width

            onClicked: {
                SelectedUser.id = styleData.value
                loadcom.source = "SetAccessLevel.qml";
            }
        }
    }

    TableViewColumn {
        id:username
        role: "username"
        title: "Username"
        width: parent.width*0.1
    }
    TableViewColumn {
        id:realname
        role: "realname"
        title: "Realname"
        width: parent.width*0.3
    }
    TableViewColumn {
        id:rfid
        role: "rfid"
        title: "RFID"
        width: parent.width*0.3
    }

    TableViewColumn {
        id:roleId
        role: "roleId"
        title: "RoleID"
        width: parent.width*0.1
    }
    TableViewColumn {
        id:timeSaldo
        role: "timeSaldo"
        title: "Time Saldo"
        width: parent.width*0.1
    }
    model: UserlistModel
    //onClicked: { console.log("onClicked");
    // text: mymodel.get(tableview.currentIndex).myproperty
    //eat }

    Component.onCompleted: {
        console.log("userlist: ");
    }

}

/*    Component.onCompleted: {
                            Services.getUserListData("beat");
                            astschview.visible = true;
                            update.visible = true;
                            }
*/
