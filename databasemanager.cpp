#include "databasemanager.h"

DatabaseManager::DatabaseManager(QObject *parent) :
    QObject(parent)
{
}

QSqlDatabase DatabaseManager::con() const
{
    return db;
}


bool DatabaseManager::openDB()
{
    // Find QSLite driver
    db = QSqlDatabase::addDatabase("QSQLITE");

#ifdef Q_OS_LINUX
    // NOTE: We have to store database file into user home folder in Linux
    //    QString path(QDir::home().path());
    QString path(QDir::current().absolutePath());
    path.append(QDir::separator()).append("my.db.sqlite");
    path = QDir::toNativeSeparators(path);
    db.setDatabaseName(path);
#else
    // NOTE: File exists in the application private folder, in Symbian Qt implementation
    db.setDatabaseName("my.db.sqlite");
#endif

    // Open databasee
    return db.open();
}

QSqlError DatabaseManager::lastError()
{
    // If opening database has failed user can ask
    // error description by QSqlError::text()
    return db.lastError();
}

bool DatabaseManager::deleteDB()
{
    // Close database
    db.close();

#ifdef Q_OS_LINUX
    // NOTE: We have to store database file into user home folder in Linux
    QString path(QDir::current().absolutePath());
    path.append(QDir::separator()).append("my.db.sqlite");
    path = QDir::toNativeSeparators(path);
    return QFile::remove(path);
#else

    // Remove created database binary file
    return QFile::remove("my.db.sqlite");
#endif
}

bool DatabaseManager::createRFID_Table()
{
    // Create table "person"
    bool ret = false;
    bool ret2 = false;
    if (db.isOpen())
    {
        QSqlQuery query;

        ret = query.exec("create table users "
                         "(id integer primary key, "
                         "roleID int, "
                         "username varchar(20), "
                         "password varchar(40), "
                         "realname varchar(40), "
                         "rfid varchar(30), "
                         "accBase int, "
                         "accBois int, "
                         "accMetal1 int, "
                         "accMetal2 int, "
                         "accCNC int, "
                         "accLASER int, "
                         "accPLASMA int, "
                         "timeSaldo int) ");

        ret = query.exec("create table activityLog "
                         "(id integer primary key, "
                         "time varchar(20), "
                         "log varchar(40))");




        ret = query.exec("create table roles "
                         "(id integer primary key, "
                         "roleId int, "
                         "roleName varchar(30))");

        if(ret>0)
        {
            ret2 = query.exec(QString("insert into roles values(NULL,%1,'%2')").arg(1).arg("RFID Admin"));
            ret2 = query.exec(QString("insert into roles values(NULL,%1,'%2')").arg(2).arg("User"));
            QDateTime dt =  QDateTime::currentDateTime();
            ret2 = query.exec(QString("insert into activityLog values(NULL,'%1','%2')").arg(dt.date().currentDate().toString()).arg("Log"));
        }


    }
    return ret;
}



int DatabaseManager::insertUser(int roleId , QString username, QString password, QString realname , QString rfid ,int timeSaldo)
{
    int newId = -1;
    bool ret = false;

    password=QCryptographicHash::hash(password.toLocal8Bit(),QCryptographicHash::Md5).toHex();

    if (db.isOpen())
    {
        //http://www.sqlite.org/autoinc.html
        // NULL = is the keyword for the autoincrement to generate next value

        QSqlQuery query;

        ret = query.exec(QString("insert into users values(NULL,%1,'%2','%3','%4','%5',%6,%7,%8,%9,%10,%11,%12,%13)")
                         .arg(roleId).arg(username).arg(password).arg(realname).arg(rfid).arg(0).arg(0).arg(0).arg(0).arg(0).arg(0).arg(0).arg(timeSaldo));

        // Get database given autoincrement value
        if (ret)
        {
            // http://www.sqlite.org/c3ref/last_insert_rowid.html
            newId = query.lastInsertId().toInt();
        }

    }
    return newId;
}


bool DatabaseManager::getAccessState(int equipementID, QString rfid, RFID*& struct_rfid)
{
    bool ret = false;

    QSqlQuery query(QString("select * from RFID_Table where equipementID = %1 and rfid = '%2'").arg(equipementID).arg(rfid));
    if (query.next())
    {
        struct_rfid->id = query.value(0).toInt();
        struct_rfid->firstname = query.value(1).toString();
        struct_rfid->lastname = query.value(2).toString();
        struct_rfid->age = query.value(3).toInt();
        struct_rfid->rfid = query.value(4).toInt();
        struct_rfid->equipementID = query.value(5).toInt();
        struct_rfid->accessState = query.value(6).toInt();
        ret = true;
    }

    return ret;
}



int DatabaseManager::insertAccessState(QString firstname, QString lastname, int age, QString rfid,int equipementID, int accessState)
{
    int newId = -1;
    bool ret = false;

    if (db.isOpen())
    {
        //http://www.sqlite.org/autoinc.html
        // NULL = is the keyword for the autoincrement to generate next value

        QSqlQuery query;
        ret = query.exec(QString("insert into RFID_Table values(NULL,'%1','%2',%3,'%4',%5,%6)")
                         .arg(firstname).arg(lastname).arg(age).arg(rfid).arg(equipementID).arg(accessState));

        // Get database given autoincrement value
        if (ret)
        {
            // http://www.sqlite.org/c3ref/last_insert_rowid.html
            newId = query.lastInsertId().toInt();
        }

    }
    return newId;
}

bool DatabaseManager::deleteAccessState(int id)
{
    bool ret = false;
    if (db.isOpen())
    {
        QSqlQuery query;
        ret = query.exec(QString("delete from RFID_Table where id=%1").arg(id));
    }
    return ret;
}


void DatabaseManager::analyseIncomming(QByteArray rxLatest)
{
    int a,b,machineID;
    QString str;
    str=rxLatest;
    addLog(str);
    a = rxLatest.indexOf("<ID>");
    b = rxLatest.indexOf("</ID>");
    if(a<b&& b-a > 4){
        str = rxLatest.mid(a+4,b-a-4);
        QTextStream(stdout)<<"Machine ID:"<<str;
    }
    machineID=str.toInt();

    QString rfid;

    a = rxLatest.indexOf("<DATA>");
    b = rxLatest.indexOf("</DATA>");
    if(a<b&& b-a > 1){
        rfid = rxLatest.mid(a+6,b-a-6);
        QTextStream(stdout)<< " - Data:"<<rfid<<endl;
    }



    //bool bStatus = false;
    //rfid = str.toInt(&bStatus,16);

    if(checkForAccess(machineID,rfid))
    {
        emit equipmentON(machineID);
    }
    else
    {
        emit equipmentOFF(machineID);
    }
}



bool DatabaseManager::checkForAccess(int machineID,QString rfid)
{
    bool ret = false;
    QSqlQuery query(QString("select * from Users where rfid = '%1'").arg(rfid));
    if (query.next())
    {
        QString id   = query.value(0).toString();
        QString username   = query.value(2).toString();
        int base   = query.value(6).toInt();
        int bois   = query.value(7).toInt();
        int metal1 = query.value(8).toInt();
        int metal2 = query.value(9).toInt();
        int cnc    = query.value(10).toInt();
        int laser  = query.value(11).toInt();
        int plasma = query.value(12).toInt();

        addLog("id:"+ id +" username:"+username+" rfid:"+rfid);
        addLog("is asking for access to equipment Nr."+machineID );

        if(base==true){
            addLog(" Access GRANTED for Equipement: "+machineID);
            ret = true;
        }
        else
        {
            addLog(" Access DENIDED for Equipement: "+machineID);
        }
    }
    return ret;
}

// Log

void DatabaseManager::addLog(QString log)
{
    bool ret = false;
    if (db.isOpen())
    {
        QSqlQuery query;
        QDateTime dt =  QDateTime::currentDateTime();
        ret=query.exec(QString("insert into activityLog values(NULL,'%1','%2')").arg(dt.date().currentDate().toString()).arg(log));
    }
}

// Tools

void millisleep2(int ms)
{
    if (ms>0)
    {
        struct timeval tv;
        tv.tv_sec=0;
        tv.tv_usec=ms*1000;
        select(0, 0, 0, 0, &tv);
    }
}
