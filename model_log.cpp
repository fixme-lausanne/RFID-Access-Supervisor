#include "model_log.h"


Model_Log::Model_Log(int id,QString datetime, QString log)
{
    m_log = log;
    m_datetime = datetime;
    m_id= id;
}

QString Model_Log::log()  const
{
    return m_log;
}

QString Model_Log::datetime()  const
{
    return m_datetime;
}

int Model_Log::id() const
{
    return m_id;
}
