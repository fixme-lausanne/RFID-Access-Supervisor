#include "session.h"

Session::Session()
{
}

QString Session::username() const
{
    return m_username;
}

void Session::setUsername(const QString &newusername)
{
    if(m_username != newusername)
    {
        m_username = newusername;
        emit usernameChanged(m_username);
    }
}

QString Session::realname() const
{
    return m_realname;
}

void Session::setRealname(const QString &newrealname)
{
    if(m_realname != newrealname)
    {
        m_realname = newrealname;
    }
}
