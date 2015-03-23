#include <QScreen>
#include <QSqlTableModel>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QThread>

#include "services.h"
#include "session.h"
#include "model_userlist.h"
#include "databasemanager.h"
#include "sounds.h"
#include "rxTxThread.h"
#include "qtquick2applicationviewer/qtquick2applicationviewer.h"


using namespace std;
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    //    QQmlApplicationEngine engine;
    QQmlContext *context = viewer.rootContext();

    Session ses;

    Model_Userlist selectedUser;

    Services svc(context,&ses);
    QObject::connect(&ses,SIGNAL(usernameChanged(QString)),&svc,SLOT(changeRealname(QString)));
    context->setContextProperty("Services",&svc);
    context->setContextProperty("Session",&ses);
    context->setContextProperty("Mainwindow",&viewer);
    context->setContextProperty("UserlistModel",QVariant::fromValue(QList<QObject*>()));
    context->setContextProperty("LogModel",QVariant::fromValue(QList<QObject*>()));
    context->setContextProperty("SelectedUser",&selectedUser);

    viewer.setSource(QUrl("qrc:/qml/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setFlags(Qt::FramelessWindowHint);


    QSize screensize = viewer.screen()->size();
    viewer.setPosition((screensize.width()/2) - (viewer.width()/2),(screensize.height()/2) - (viewer.height()/2));
    viewer.showExpanded();


    QThread RxTxThread;
    rxTxThread *ttyThread = new rxTxThread;
    ttyThread->moveToThread(&RxTxThread);

    //Sounds mysounds;


    //QObject::connect(ttyThread, SIGNAL(cardDetected()),&mysounds, SLOT(playCameraFlash()));
    QObject::connect(ttyThread, SIGNAL(cardRxLatest(QByteArray)),&svc.m_con, SLOT(analyseIncomming(QByteArray)));
    QObject::connect(&svc.m_con,SIGNAL(equipmentON(int)),ttyThread,SLOT(turnEquipementON(int)));
    QObject::connect(&svc.m_con,SIGNAL(equipmentOFF(int)),ttyThread,SLOT(turnEquipementOFF(int)));

    RxTxThread.start();

    QSqlTableModel *model = new QSqlTableModel();
    model->setTable("RFID_Table");
    model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    model->select();
    model->removeColumn(0); // don't show the ID

    return app.exec();
}
