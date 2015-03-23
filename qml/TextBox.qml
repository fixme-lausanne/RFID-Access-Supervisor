import QtQuick 2.0

Rectangle{
    id:root
    property alias maxLength: textinput.maximumLength
    property bool isPassword: false
    property alias text: textinput.text
    property alias isFocus: textinput.focus
    property bool isOnlyDigit: false
    property bool isOnlyDigitAndAlphabet: false
    property bool isDate: false
    border{color:"black"}
    signal enter
    radius: 3
    TextInput{
        id: textinput
        font{
            bold: true
            pixelSize: 12
        }
        width: parent.width-10
        focus: isFocus
        anchors.centerIn: parent
        autoScroll: true
        echoMode: isPassword?TextInput.Password:TextInput.Normal
        maximumLength: 10
        validator: RegExpValidator{
            regExp: isOnlyDigit?/[0-9]*/:isOnlyDigitAndAlphabet?/([0-9a-zA-Z]*)/:isDate?/[1-9][0-9][0-9][0-9]\-[0-3][0-9]\-[0-1][0-9][ ][0-2][0-9]\:[0-5][0-9]/:/.*/
        }
        onAccepted: {
            root.enter();
        }
    }
}
