#ifndef SERIAL_H
#define SERIAL_H


#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QByteArray>


class rxTxThread : public QObject
{
    Q_OBJECT
public:
    explicit rxTxThread(QObject *parent = 0);
    ~rxTxThread();

private:
    QSerialPort *serPort;
    void initSerialPort();
    QByteArray rxData;
    QByteArray rxLatest;
    bool directionTx;

signals:
    void cardDetected();
    void cardRxLatest(QByteArray rxLatest);

public slots:
    void readData();
    void handleError(QSerialPort::SerialPortError error);
    void turnEquipementON(int eqID);
    void turnEquipementOFF(int eqID);

};

#endif // SERIAL_H
