import QtQuick 2.0

Item {
    function doInsert(){
        if(cmbAst.text=="Choose Assistant" || cmbCO.text=="Choose CO"
                || txtBoxClass.text.trim() == "" || txtBoxEndTime.text.trim()==""
                || txtBoxMeeting.text.trim()=="" || txtBoxRoom.text.trim()==""
                || txtBoxStartTime.text.trim()=="")
        {
            errMsg.text = "All fields must be filled";
            errMsg.color = "red";
            errMsg.visible = "true";
        }
        else{
            var result = Services.insertUser(cmbAst.text,cmbCO.text+" "+txtBoxClass.text+" "+txtBoxRoom.text+" "+txtBoxMeeting.text,
                                             txtBoxStartTime.text,txtBoxEndTime.text);
            if(result)
            {
                errMsg.text = "User inserted successfully";
                errMsg.color = "green";
                errMsg.visible = "true";
            }
            else
            {
                errMsg.text = "Failed to insert User";
                errMsg.color = "red";
                errMsg.visible = "true";
            }
        }
    }

    Text{
        id: txtAst
        text: "Assistant"
        anchors{
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 10
        }
    }
    Combobox{
        id: cmbAst
        width: 150
        height: 20
        text: "Choose Assistant"
        mod: Services.getTeachingAssistantUsernames()
        anchors{
            left: txtAst.right
            leftMargin: 50
            verticalCenter: txtAst.verticalCenter
        }
    }
    Text{
        id: txtCourseOutline
        text: "Course Outline"
        anchors{
            left: txtAst.left
            top: txtAst.bottom
            topMargin: 10
        }
    }
    Combobox{
        id: cmbCO
        width: 250
        height: 20
        text: "Choose CO"
        mod: Services.getCourseOutlines()
        anchors{
            left: cmbAst.left
            verticalCenter: txtCourseOutline.verticalCenter
        }
    }
    Text{
        id: txtClass
        text: "Class"
        anchors{
            left: txtCourseOutline.left
            top: txtCourseOutline.bottom
            topMargin: 10
        }
    }
    TextBox{
        id: txtBoxClass
        width: 50
        height: 20
        anchors{
            left: cmbAst.left
            verticalCenter: txtClass.verticalCenter
        }
        isOnlyDigitAndAlphabet: true
        isPassword: false
        maxLength: 5
    }
    Text{
        id: txtRoom
        text: "Room"
        anchors{
            left: txtClass.left
            top: txtClass.bottom
            topMargin: 10
        }
    }
    TextBox{
        id: txtBoxRoom
        width: 50
        height: 20
        isOnlyDigitAndAlphabet: true
        anchors{
            left: cmbAst.left
            verticalCenter: txtRoom.verticalCenter
        }
        isPassword: false
        maxLength: 5
    }
    Text{
        id: txtMeeting
        text: "Meeting"
        anchors{
            left: txtRoom.left
            top: txtRoom.bottom
            topMargin: 10
        }
    }
    TextBox{
        id: txtBoxMeeting
        isOnlyDigit: true
        width: 30
        height: 20
        anchors{
            left: cmbAst.left
            verticalCenter: txtMeeting.verticalCenter
        }
        isPassword: false
        maxLength: 2
    }
    Text{
        id: txtStartTime
        text: "StartTime"
        anchors{
            left: txtMeeting.left
            top: txtMeeting.bottom
            topMargin: 10
        }
    }
    TextBox{
        id: txtBoxStartTime
        isDate: true
        width: 150
        height: 20
        anchors{
            left: cmbAst.left
            verticalCenter: txtStartTime.verticalCenter
        }
        maxLength: 16
    }
    Text{
        id: txtEndTime
        text: "EndTime"
        anchors{
            left: txtStartTime.left
            top: txtStartTime.bottom
            topMargin: 10
        }
    }
    TextBox{
        id: txtBoxEndTime
        isDate: true
        width: 150
        height: 20
        anchors{
            left: cmbAst.left
            verticalCenter: txtEndTime.verticalCenter
        }
        maxLength: 16
    }

    Rectangle{
        id: btnsave
        radius: 3
        width: 50
        height: 20
        Text{
            text: "Save"
            anchors.centerIn: parent
        }
        anchors{
            top: txtBoxEndTime.bottom
            topMargin: 10
            right: txtBoxEndTime.right
        }
        gradient:Gradient{
            GradientStop{position: 0.0; color: "white";}
            GradientStop{position: 0.3; color: "lightgrey";}
            GradientStop{position: 0.7; color: "grey";}
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                doInsert();
            }
        }
    }
    Text{
        id: errMsg
        visible:false
        anchors{
            verticalCenter: btnsave.verticalCenter
            right: btnsave.left
            rightMargin: 10
        }
    }

}
