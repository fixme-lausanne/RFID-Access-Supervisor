#include "model_userlist.h"

Model_Userlist::Model_Userlist()
{
    m_id = 1;
    m_roleId = 2;
    m_username = "?";
    m_realname = "??";
    m_rfid = "???";
}

Model_Userlist::Model_Userlist(int id, int roleId, QString username, QString realname, QString rfid, int timeSaldo)
{
    m_id = id;
    m_roleId = roleId;
    m_username = username;
    m_realname = realname;
    m_rfid = rfid;
    m_timeSaldo = timeSaldo;
}

int Model_Userlist::roleId() const
{
    return m_roleId;
}

int Model_Userlist::timeSaldo() const
{
    return m_timeSaldo;
}

QString Model_Userlist::username() const
{
    return m_username;
}

QString Model_Userlist::realname() const
{
    return m_realname;
}

QString Model_Userlist::rfid() const
{
    return m_rfid;
}

int Model_Userlist::id() const
{
    return m_id;
}

void Model_Userlist::setId(int id)
{
    m_id=id;
}
