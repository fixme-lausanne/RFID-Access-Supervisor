import QtQuick 2.0
import QtQuick.Controls 1.1


TableView {
    id:logView
    clip: true;
    model: LogModel;

    anchors{
        //      top: parent.top
        topMargin: 10
        //      left: parent.left
        leftMargin: 5
        //      right: parent.right
        rightMargin: 5
        //      bottom: parent.bottom
        bottomMargin: 10
    }
    // width: parent.width
    // height: parent.height-50

    TableViewColumn {
        id:id2
        role: "id"
        title: "ID"
        //    width: parent.width*0.1
    }

    TableViewColumn {
        id:datetime
        role: "datetime"
        title: "Datetime"
        //    width: parent.width*0.2
    }
    TableViewColumn {
        id:log
        role: "log"
        title: "Log"
        //   width: parent.width*0.7
    }

    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: Services.getLogData();
    }

    Component.onCompleted: {
        Services.getLogData();
        console.log("activityLog: ");
    }

}
