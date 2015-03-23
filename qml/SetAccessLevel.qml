import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

Item{
    id: accLevel
    property int userID: SelectedUser.id
    Text{
        id: accLevelTxt
        text: "Accès par catégories d'outillages"
        visible: false
        color: "red"
        font{
            pixelSize: 15
            bold: false
            family: "Arial"
        }
        anchors{
            topMargin: 30
        }
    }

    Rectangle{
        id:rect1_1
        width: parent.width*0.3
        height: 20
        anchors{
            top: accLevelTxt.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width*0.05
        }
        radius: 5
        gradient:Gradient{
            GradientStop{position: 0.0; color: "lightgrey"}
            GradientStop{position: 0.1; color: "white"}
            GradientStop{position: 0.9; color: "lightgrey"}
        }
        border.color: "black"
        Text{
            text: "Catégorie"
            color: "black"
            font{
                pixelSize: 10
                bold: true
                family: "Arial"
            }
            anchors.centerIn: parent
        }
    }

    Rectangle{
        id:rect1_2
        width: parent.width*0.6
        height: 20
        anchors{
            top: accLevelTxt.bottom
            topMargin: 20
            left: rect1_1.right
        }
        radius: 5
        gradient:Gradient{
            GradientStop{position: 0.0; color: "lightgrey"}
            GradientStop{position: 0.1; color: "white"}
            GradientStop{position: 0.9; color: "lightgrey"}
        }
        border.color: "black"
        Text{
            text: "Outillage"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.centerIn: parent
        }
    }


    ////  Base

    Rectangle{
        id:rect2_1
        width: parent.width*0.3
        height: 30
        anchors{
            top: rect1_1.bottom
            left: parent.left
            leftMargin: parent.width*0.05
        }
        border.color: "black"
        StateButtonBG{
            buttonState: Services.getAccessLevel(userID,"Base");

            onButtonStateChanged:{
                Services.setAccessLevel(userID,"Base",buttonState);
            }
        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.5 + 10
            anchors.verticalCenter: parent.verticalCenter
            text: "Base"
            color: "black"
            font{
                pixelSize: 16
                family: "Arial"
            }
        }

    }

    Rectangle{
        id:rect2_2
        width: parent.width*0.6
        height: 30
        anchors{
            top: rect1_2.bottom
            left: rect2_1.right
        }
        border.color: "black"
        Text{
            text: "Outillage à main de base (tournevis, clés, marteaux...), visseuses,
perceuse, scie à chantourner, ponceuse, lapidaire"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.Center
        }
    }

    ////  Bois

    Rectangle{
        id:rect3_1
        width: parent.width*0.3
        height: 30
        anchors{
            top: rect2_1.bottom
            left: parent.left
            leftMargin: parent.width*0.05
        }
        border.color: "black"
        StateButtonBG{
            buttonState: Services.getAccessLevel(userID,"Bois");
            onButtonStateChanged:{
                Services.setAccessLevel(userID,"Bois",buttonState);
            }

        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.5 + 10
            anchors.verticalCenter: parent.verticalCenter
            text: "Bois"
            color: "black"
            font{
                pixelSize: 16
                family: "Arial"
            }
        }

    }

    Rectangle{
        id:rect3_2
        width: parent.width*0.6
        height: 30
        anchors{
            top: rect2_2.bottom
            left: rect3_1.right
        }
        border.color: "black"
        Text{
            text: "Electroportatif bois: Scie sauteuse, circulaire plongeante, défonceuse,
rabot, mortaiseuse. Stationnaire bois: Scie à ruban, scie à onglet"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.Center
        }
    }

    ////  Metal 1

    Rectangle{
        id:rect4_1
        width: parent.width*0.3
        height: 30
        anchors{
            top: rect3_1.bottom
            left: parent.left
            leftMargin: parent.width*0.05
        }
        border.color: "black"
        StateButtonBG{
            buttonState: Services.getAccessLevel(userID,"Metal1");
            onButtonStateChanged:{
                Services.setAccessLevel(userID,"Metal1",buttonState);
            }

        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.5 + 10
            anchors.verticalCenter: parent.verticalCenter
            text: "Metal 1"
            color: "black"
            font{
                pixelSize: 16
                family: "Arial"
            }
        }

    }

    Rectangle{
        id:rect4_2
        width: parent.width*0.6
        height: 30
        anchors{
            top: rect3_2.bottom
            left: rect4_1.right
        }
        border.color: "black"
        Text{
            text: "Electroportatif métal: Meuleuse, tronçonneuse à métal, soudage MIG, touret à meuler"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.Center
        }
    }


    ////  Metal 2

    Rectangle{
        id:rect5_1
        width: parent.width*0.3
        height: 30
        anchors{
            top: rect4_1.bottom
            left: parent.left
            leftMargin: parent.width*0.05
        }
        border.color: "black"
        StateButtonBG{
            buttonState: Services.getAccessLevel(userID,"Metal2");
            onButtonStateChanged:{
                Services.setAccessLevel(userID,"Metal2",buttonState);
            }

        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.5 + 10
            anchors.verticalCenter: parent.verticalCenter
            text: "Metal 2"
            color: "black"
            font{
                pixelSize: 16
                family: "Arial"
            }
        }

    }

    Rectangle{
        id:rect5_2
        width: parent.width*0.6
        height: 30
        anchors{
            top: rect4_2.bottom
            left: rect5_1.right
        }
        border.color: "black"
        Text{
            text: "Stationnaire métal: Tours, fraiseuse manuelle"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.Center
        }
    }


    ////  CNC

    Rectangle{
        id:rect6_1
        width: parent.width*0.3
        height: 30
        anchors{
            top: rect5_1.bottom
            left: parent.left
            leftMargin: parent.width*0.05
        }
        border.color: "black"
        StateButtonBG{
            buttonState: Services.getAccessLevel(userID,"CNC");
            onButtonStateChanged:{
                Services.setAccessLevel(userID,"CNC",buttonState);
            }

        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.5 + 10
            anchors.verticalCenter: parent.verticalCenter
            text: "CNC"
            color: "black"
            font{
                pixelSize: 16
                family: "Arial"
            }
        }

    }

    Rectangle{
        id:rect6_2
        width: parent.width*0.6
        height: 30
        anchors{
            top: rect5_2.bottom
            left: rect6_1.right
        }
        border.color: "black"
        Text{
            text: "Fraiseuse CNC"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.Center
        }
    }



    ////  LASER

    Rectangle{
        id:rect7_1
        width: parent.width*0.3
        height: 30
        anchors{
            top: rect6_1.bottom
            left: parent.left
            leftMargin: parent.width*0.05
        }
        border.color: "black"
        StateButtonBG{
            buttonState: Services.getAccessLevel(userID,"LASER");
            onButtonStateChanged:{
                Services.setAccessLevel(userID,"LASER",buttonState);
            }

        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.5 + 10
            anchors.verticalCenter: parent.verticalCenter
            text: "LASER"
            color: "black"
            font{
                pixelSize: 16
                family: "Arial"
            }
        }
    }

    Rectangle{
        id:rect7_2
        width: parent.width*0.6
        height: 30
        anchors{
            top: rect6_2.bottom
            left: rect7_1.right
        }
        border.color: "black"
        Text{
            text: "Découpeuse laser"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.Center
        }
    }



    ////  PLASMA

    Rectangle{
        id:rect8_1
        width: parent.width*0.3
        height: 30
        anchors{
            top: rect7_1.bottom
            left: parent.left
            leftMargin: parent.width*0.05
        }
        border.color: "black"
        StateButtonBG{
            buttonState: Services.getAccessLevel(userID,"PLASMA");
            onButtonStateChanged:{
                Services.setAccessLevel(userID,"PLASMA",buttonState);
            }

        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.5 + 10
            anchors.verticalCenter: parent.verticalCenter
            text: "PLASMA"
            color: "black"
            font{
                pixelSize: 16
                family: "Arial"
            }
        }
    }

    Rectangle{
        id:rect8_2
        width: parent.width*0.6
        height: 30
        anchors{
            top: rect7_2.bottom
            left: rect8_1.right
        }
        border.color: "black"
        Text{
            text: "Découpeuse plasma"
            color: "black"
            font{
                pixelSize: 12
                family: "Arial"
            }
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.Center
        }
    }
}
