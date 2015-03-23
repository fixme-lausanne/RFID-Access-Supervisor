#ifndef MODEL_USERLIST_H
#define MODEL_USERLIST_H

#include <QObject>

class Model_Userlist : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(int roleId READ roleId NOTIFY roleIdChanged)
    Q_PROPERTY(QString username READ username NOTIFY usernameChanged)
    Q_PROPERTY(QString realname READ realname NOTIFY realnameChanged)
    Q_PROPERTY(QString rfid READ rfid NOTIFY rfidChanged)
    Q_PROPERTY(int timeSaldo READ timeSaldo NOTIFY timeSaldoChanged)
public:
    Model_Userlist(int id, int roleId, QString username, QString realname, QString rfid, int timeSaldo);
    Model_Userlist();
    int roleId() const;
    int timeSaldo() const;
    QString username() const;
    QString realname() const;
    QString rfid() const;
    int id() const;
    void setId(int id);
    /*void setType( const QString &newtype);
    void setDesc( const QString &newdesc);
    void setStartTime( const QString &newstarttime);
    void setEndTime( const QString &newendtime);
    void setStat( const QString &newstat);*/
signals:
    void idChanged();
    void roleIdChanged();
    void usernameChanged();
    void realnameChanged();
    void rfidChanged();
    void timeSaldoChanged();
private:
    int m_id;
    int m_roleId;
    QString m_username;
    QString m_realname;
    QString m_rfid;
    int m_timeSaldo;
};

#endif // MODEL_USERLIST_H

