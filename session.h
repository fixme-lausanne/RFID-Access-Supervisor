#ifndef SESSION_H
#define SESSION_H

#include <QObject>

class Session : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString username READ username WRITE setUsername NOTIFY usernameChanged)
    Q_PROPERTY(QString realname READ realname NOTIFY realnameChanged)
public:
    Session();
    QString username() const;
    void setUsername(const QString &newusername);
    QString realname() const;
    void setRealname(const QString &newrealname);

signals:
    void usernameChanged(QString username);
    void realnameChanged();

private:
    QString m_username;
    QString m_realname;
};

#endif // SESSION_H
