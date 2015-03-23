#include "services.h"


using namespace std;

Services::Services(QQmlContext *ctxt, Session *sess)
{
    m_ctxt = ctxt;
    m_ses = sess;
    //m_con.doConnect("QMYSQL","localhost","CPPQMLDatabase","root","");
    m_con.openDB();

    int feedback;
    feedback = m_con.createRFID_Table();
    cout<<"TableRFIDCreatedDB: "<<feedback<<endl;
    // feedback = m_con.insertAccessState("Elena","Gerber",14,"380046E27",1,1);
    // cout<<"InsertDB: "<<feedback<<endl;
    //feedback = m_con.createUsers_Table();
    //cout<<"TableUsersCreatedDB: "<<feedback<<endl;
    if(feedback>0)
    {

        feedback= m_con.insertUser(1,"beat","beat","Beat Gerber","1380046E2",100);
        feedback= m_con.insertUser(1,"marc","marc","Marc Wettstein","380046E27",100);
    }
    cout<<"InsertDB: "<<feedback<<endl;
}

bool Services::doLogin(QString username, QString password)
{
    QSqlQuery query(m_con.con());
    QString pw= QCryptographicHash::hash(password.toLocal8Bit(),QCryptographicHash::Md5).toHex();
    query.exec(QString("Select * from users where username = '%1' and password = '%2'").arg(username).arg(pw));
    return query.next();
}

void Services::getUserListData(QString username)
{
    QList<QObject *> data;
    QSqlQuery query(m_con.con());
    int userID = getUserID(username);
    if(getUserRole(userID)=="RFID Admin")
    {
        QString qstr = QString("Select id,roleId,username,realname,rfid,timeSaldo from Users" );
        query.exec(qstr);
        while(query.next())
        {
            data.append(new Model_Userlist(query.value("Id").toInt(),query.value("RoleId").toInt(),query.value("Username").toString(),query.value("Realname").toString(),query.value("rfid").toString(),query.value("timeSaldo").toInt()));
        }
    }
    m_ctxt->setContextProperty("UserlistModel",QVariant::fromValue(data));

}



void Services::getUserData(QString username)
{
    QList<QObject *> data;
    QSqlQuery query(m_con.con());
    int userID = getUserID(username);
    if(getUserRole(userID)=="RFID Admin")
    {
        QString qstr = QString("Select id,roleId,username,realname,rfid,timeSaldo from Users"); //where userId = ?");
        query.exec(qstr);
        while(query.next())
        {
            data.append(new Model_Userlist(query.value("id").toInt(),query.value("roleId").toInt(),query.value("username").toString(),query.value("realname").toString(),query.value("rfid").toString(),query.value("timeSaldo").toInt()));
        }
    }
    m_ctxt->setContextProperty("UserlistModel",QVariant::fromValue(data));
}

void Services::changeRealname(QString username)
{
    QSqlQuery query(m_con.con());
    QString qstr = QString("Select realname from Users where username = '%1'").arg(username);
    query.exec(qstr);
    if(query.next())m_ses->setRealname(query.value("realname").toString());
}

int Services::getUserID(QString username)
{
    QSqlQuery query(m_con.con());
    QString qstr = QString("Select id from Users where username = '%1'").arg(username);
    query.exec(qstr);
    if(query.next())
    {
        return query.value(0).toInt();
    }
    return 0;
}

QString Services::getUserRole(int userID)
{
    QSqlQuery query(m_con.con());
    //QString qstr = QString("Select RoleName from Roles a join UserInRole b on a.RoleID = b.RoleID where b.UserID = %1").arg(userID);
    QString qstr = QString("Select RoleName from Roles  join users  on Roles.id = users.RoleID where users.id = %1").arg(userID);
    query.exec(qstr);
    bool res = query.next();
    if(res)
    {
        return query.value(0).toString();
    }
    else return "";
}


// User Functions

bool Services::updateUser(int id, int roleId, QString username, QString realname, QString rfid,int timeSaldo)
{
    QSqlQuery query(m_con.con());
    QString qstr = QString("Update Users set roleId = %1, username = '%2', realname = '%3', rfid = '%4', timeSaldo = %5 where id = %6").arg(roleId).arg(username).arg(realname).arg(rfid).arg(timeSaldo).arg(id);
    return query.exec(qstr);
}

bool Services::insertUser(int roleId, QString username, QString realname, QString rfid,int timeSaldo)
{
    QSqlQuery query(m_con.con());

    //int id = getUserID(username);
    QString qstr = QString("Insert into Users (roleId,username,realname,rfid,accBase,accBois,accMetal1,accMetal2,accCNC,accLASER,accPLASMA,timeSaldo) Values(%1,'%2','%3','%4',%5,%6,%7,%8,%9,%10,%11,%12)").arg(roleId).arg(username).arg(realname).arg(rfid).arg(0).arg(0).arg(0).arg(0).arg(0).arg(0).arg(0).arg(timeSaldo);
    return query.exec(qstr);
}

bool Services::deleteUser(int id)
{
    QSqlQuery query(m_con.con());
    QString qstr = QString("Delete from Users where id = %1").arg(id);
    return query.exec(qstr);
}

// Access Level functions
int Services::getAccessLevel(int userID,QString accessLevelString)
{
    QSqlQuery query(m_con.con());
    QString qstr = QString("Select %1 from Users where id = '%2'").arg("acc"+accessLevelString).arg(userID);
    query.exec(qstr);
    if(query.next())
    {
        return query.value(0).toInt();
    }
    return 0;

}

bool Services::setAccessLevel(int userID,QString accessLevelString,int accessLevelState)
{
    QSqlQuery query(m_con.con());
    QString qstr = QString("Update Users set %1 = %2 where id = %3").arg("acc"+accessLevelString).arg(accessLevelState).arg(userID);
    return query.exec(qstr);
}


// Log

void Services::getLogData()
{
    QList<QObject *> data;
    QSqlQuery query(m_con.con());
    QString qstr = QString("Select id,time,log from activityLog order by id desc limit 100" );
    query.exec(qstr);
    while(query.next())
    {
        int i =query.value("id").toInt();
        QString qs1 =query.value("time").toString();
        QString qs2= query.value("log").toString();
        data.append(new Model_Log(i,qs1,qs2));
    }

    m_ctxt->setContextProperty("LogModel",QVariant::fromValue(data));

}

// Special


