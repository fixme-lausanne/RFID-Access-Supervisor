#ifndef SERVICES_H
#define SERVICES_H
#include <QObject>
#include <QStringList>
#include <QQmlContext>
#include <QSqlQuery>
#include <QVariant>
#include <QDebug>
#include <QCryptographicHash>
#include <QDateTime>
#include <iostream>

#include "model_userlist.h"
#include "model_log.h"
#include "databasemanager.h"
#include "session.h"


class QString;

class Services : public QObject
{
    Q_OBJECT
public:
    Services(QQmlContext *ctxt, Session *sess);
    Q_INVOKABLE bool doLogin(QString username, QString password);
    Q_INVOKABLE void getUserListData(QString username);
    Q_INVOKABLE void getUserData(QString username);

    Q_INVOKABLE int getAccessLevel(int userID,QString accessLevel);
    Q_INVOKABLE bool setAccessLevel(int userID,QString accessLevel,int accessLevelState);

    Q_INVOKABLE QString getUserRole(int userID);

    Q_INVOKABLE bool updateUser(int id, int roleId, QString username, QString realname, QString rfid,int timeSaldo);
    Q_INVOKABLE bool insertUser(int roleId, QString username , QString realname, QString rfid,int timeSaldo);
    Q_INVOKABLE bool deleteUser(int id);
    Q_INVOKABLE int getUserID(QString username);

    Q_INVOKABLE void getLogData();
    DatabaseManager m_con;

public slots:
    void changeRealname(QString username);
signals:
    void updateTimeout();
private:
    QQmlContext *m_ctxt;
    Session *m_ses;
};

#endif // SERVICES_H

