#ifndef MODEL_LOG_H
#define MODEL_LOG_H

#include <QObject>

class Model_Log : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(QString datetime READ datetime NOTIFY datetimeChanged)
    Q_PROPERTY(QString log READ log NOTIFY logChanged)
    Q_PROPERTY(int id READ id NOTIFY idChanged)
public:
    Model_Log(int id,QString datetime, QString log);

    QString datetime() const;
    QString log() const;
    int id() const;

private:
    QString m_datetime;
    QString m_log;
    int m_id;

signals:
    void datetimeChanged();
    void logChanged();
    void idChanged();

public slots:

};

#endif // MODEL_LOG_H
