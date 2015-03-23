import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2




Button {


    function setButtonname()
    {
        var buttontext = "Interdit"
        if(buttonState == 1)
        {
            buttontext = "Rookie"
        }
        if(buttonState == 2)
        {
            buttontext = "Debutant"
        }
        if(buttonState == 3)
        {
            buttontext = "Apprenti"
        }
        if(buttonState == 4)
        {
            buttontext = "Confirme"
        }
        if(buttonState == 5)
        {
            buttontext = "Expert"
        }
        if(buttonState == 6)
        {
            buttontext = "Ninja"
        }
        if(buttonState == 7)
        {
            buttontext = "Guru"
        }
        return buttontext
    }

    anchors.verticalCenter: parent.verticalCenter
    text: setButtonname();
    property int buttonState: 0
    signal onButtonStateChange()

    width: parent.width*0.5


    style: ButtonStyle {
        background: Rectangle {
            implicitWidth: 50
            implicitHeight: 25
            border.width: control.activeFocus ? 2 : 1
            border.color: "#888"
            anchors{
                //topMargin: 20
                left: parent.left
                leftMargin: parent.width*0.02
            }

            radius: 4
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
            }

            Image {

                function setFile()
                {
                    var filename = "../pix/InterditIcon.png"
                    if(buttonState == 1)
                    {
                        filename = "../pix/Rookie.png"
                    }
                    if(buttonState == 2)
                    {
                        filename = "../pix/Debutant.png"
                    }
                    if(buttonState == 3)
                    {
                        filename = "../pix/Apprenti.png"
                    }
                    if(buttonState == 4)
                    {
                        filename = "../pix/Confirme.png"
                    }
                    if(buttonState == 5)
                    {
                        filename = "../pix/Expert.png"
                    }
                    if(buttonState == 6)
                    {
                        filename = "../pix/WorkshopNinja.png"
                    }
                    if(buttonState == 7)
                    {
                        filename = "../pix/WorkshopGuru.png"
                    }
                    return filename
                }


                height: parent.height
                anchors.left:  parent.left
                source:setFile();
                //              anchors.right:  parent.right
                fillMode: Image.PreserveAspectFit

            }
        }
    }

    onClicked: {

        if(buttonState>=7){buttonState=0}else{buttonState++;}
        onButtonStateChange();
    }
}
