#include "rxTxThread.h"

using namespace std;
void millisleep(int ms)
{
    if (ms>0)
    {
        struct timeval tv;
        tv.tv_sec=0;
        tv.tv_usec=ms*1000;
        select(0, 0, 0, 0, &tv);
    }
}

rxTxThread::rxTxThread(QObject *parent) :
    QObject(parent)
{
    directionTx = false;
    serPort = new QSerialPort(this);
    initSerialPort();
    connect(serPort, SIGNAL(error(QSerialPort::SerialPortError)), this,
            SLOT(handleError(QSerialPort::SerialPortError)));

    connect(serPort, SIGNAL(readyRead()), this, SLOT(readData()));

    //serPort->flush();
    //serPort->write("<SET><ID>1</ID><STATE>1</STATE></SET>");

}

rxTxThread::~rxTxThread()
{
    turnEquipementOFF(1);
}

void rxTxThread::initSerialPort()
{
    serPort->setPortName("/dev/ttyACM0");
    // serPort->setPortName("/dev/ttyUSB0");
    if (serPort->open(QIODevice::ReadWrite))
    {
        serPort->setBaudRate(QSerialPort::Baud9600,QSerialPort::AllDirections);
        serPort->setDataBits(QSerialPort::Data8);
        serPort->setParity(QSerialPort::NoParity);
        serPort->setStopBits(QSerialPort::OneStop);
        serPort->setFlowControl(QSerialPort::NoFlowControl);
    }

    else {
        serPort->close();
        /*        QMessageBox::critical(this, tr("Error"),
            tr("Can't configure the serial port: %1,\n"
            "error code: %2")
            .arg("/dev/ttyACM1").arg(serial->error()));
            ui->statusBar->showMessage(tr("Open error"));*/
    }

}

void rxTxThread::readData()
{
    if(directionTx==false)
    {
        QString str="";
        QByteArray rxBytes = serPort->readAll();
        rxData.append(rxBytes);
        if(rxData.contains("</STN>"))// || rxData.size()>60)
        {
            //QTextStream(stdout)<<rxLatest<<endl; //debug
            rxLatest=rxData;
            emit cardDetected();
            emit cardRxLatest(rxLatest);
            rxData = "";
        }
    }
}

void rxTxThread::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        //QMessageBox::critical(this, tr("Critical Error"), serial->errorString());
        //closeSerialPort();
    }
}

void rxTxThread::turnEquipementON(int eqID)
{
    directionTx=true;
    QByteArray str = "<SET><ID>1</ID><STATE>1</STATE></SET>";
    char c0;
    int i;
    serPort->flush();
    millisleep(100);
    for(i=0;i<str.size();i++)
    {
        c0 = str.at(i);
        serPort->write(&c0,1);
        serPort->waitForBytesWritten(10);
        millisleep(10);
    }
    directionTx=false;

}


void rxTxThread::turnEquipementOFF(int eqID)
{
    QByteArray str = "<SET><ID>1</ID><STATE>0</STATE></SET>";
    char c0;
    int i;
    serPort->flush();
    millisleep(100);
    for(i=0;i<str.size();i++)
    {
        c0 = str.at(i);
        serPort->write(&c0,1);
        serPort->waitForBytesWritten(10);
        millisleep(10);
    }
    directionTx=false;
}
