import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Rectangle{
    id: container

    function changeWindowSize(mainwindow,width,height){
        mainwindow.setWidth(width);
        mainwindow.setHeight(height);
        mainwindow.setX((Screen.width-width)/2);
        mainwindow.setY((Screen.height-height)/2);
    }

    Loader{
        id: loader
        anchors{
            centerIn: parent
        }
    }
    states: [
        State{
            name: "Login"
            PropertyChanges {
                target: loader
                source: "Login.qml"
            }
            StateChangeScript{
                name: "changeMainWindow"
                script: changeWindowSize(Mainwindow,300,150);
            }
        },
        State{
            name: "MainMenu"
            PropertyChanges {
                target: loader
                source: "MainMenu.qml"
            }
            StateChangeScript{
                name: "changeMainWindow"
                script: changeWindowSize(Mainwindow,780,535);
            }
        },
        State{
            name: "AstSpv"
            PropertyChanges {
                target: loader
                source: "AstSpv.qml"
            }
            StateChangeScript{
                name: "changeMainWindow"
                script: changeWindowSize(Mainwindow,850,535);
            }
        }
    ]
    Component.onCompleted: container.state = "Login"
}
