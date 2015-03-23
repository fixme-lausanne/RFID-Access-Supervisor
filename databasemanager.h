#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QVariant>
#include <QFile>
#include <QDir>
#include <QString>
#include <QTextStream>
#include <QCryptographicHash>
#include <QDateTime>


class RFID
    {
    public:
        int id;
        QString firstname;
        QString lastname;
        int age;
        QString rfid;
        int equipementID;
        int accessState;
    };


class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = 0);

    bool openDB();
    bool createRFID_Table();
    int insertUser(int roleId , QString username, QString password, QString realname , QString rfid , int timeSaldo);
    int insertAccessState(QString firstname, QString lastname, int age, QString rfid,int equipementID, int accessState);
    bool getAccessState(int equipementID, QString rfid, RFID*& struct_rfid);
    bool deleteAccessState(int id);

    bool deleteDB();
    QSqlError lastError();
    QSqlDatabase con() const;
    void addLog(QString log);
    bool checkForAccess(int machineID,QString rfid);

private:
    QSqlDatabase db;


signals:
    void equipmentON(int eqID);
    void equipmentOFF(int eqID);

public slots:
    void analyseIncomming(QByteArray rxLatest);

};

#endif // DATABASEMANAGER_H
