#include "framelesswindowhelper.h"
#include "windowhandler.h"
#include <QQuickItem>
#include <QDebug>

FramelessWindowHelper::FramelessWindowHelper(QObject *parent) :
    QObject(parent)
{
}

FramelessWindowHelper::~FramelessWindowHelper()
{
    QObjectList keys = windows.keys();
    foreach (QObject *obj, keys) {
        delete windows.value(obj);
    }
}

void FramelessWindowHelper::classBegin()
{

}

void FramelessWindowHelper::componentComplete()
{
    auto obj = parent();
    while (Q_NULLPTR != obj) {
        if (obj->inherits("QQuickRootItem")) {
            if (auto rootItem = qobject_cast<QQuickItem *>(obj)) {
                if (auto window = rootItem->window()) {
                    if (!windows.contains(window)) {
                        window->installEventFilter(this);
                        windows.insert(window, new WindowHandler(window));
                    }
                    break;
                }
            }
        }

        obj = obj->parent();
    }
}

void FramelessWindowHelper::addWindow(const QString &objName)
{
    //    if (!engine || engine->rootObjects().isEmpty() || objName.isEmpty())
    //        return;

    //    for (int i = 0; i < engine->rootObjects().size(); ++i) {
    //        QObject *rootObj = engine->rootObjects()[i];

    //        if (rootObj) {
    //            if (rootObj->isWindowType() && !windows.contains(rootObj)) {
    //                windows.insert(rootObj, new WindowHandler(qobject_cast<QQuickWindow*>(rootObj)));
    //                rootObj->installEventFilter(this);
    //            }

    //            QObjectList objs = rootObj->findChildren<QObject*>(objName);
    //            for (int j = 0; j < objs.size(); ++j) {
    //                if (objs[j]->isWindowType() && !windows.contains(objs[j])) {
    //                    windows.insert(objs[j], new WindowHandler(qobject_cast<QQuickWindow*>(objs[j])));
    //                    objs[j]->installEventFilter(this);
    //                }
    //            }
    //        }
    //    }
}

void FramelessWindowHelper::addWindow(QObject *obj)
{
    if (obj) addWindow(obj->objectName());
}


bool FramelessWindowHelper::eventFilter(QObject *watched, QEvent *event)
{
//    qDebug() << watched << "eventFilter";
    switch (event->type()) {
    case QEvent::MouseButtonPress:
    case QEvent::MouseMove:
    case QEvent::MouseButtonRelease:
    {
        WindowHandler *handler = windows.value(watched);
        qDebug() << handler << "handler";
        if (handler) {
            handler->handleEvent(event);
            if (handler->isResizing())
                return true;
        }
    }
        break;
    default:
        break;
    }
    return QObject::eventFilter(watched, event);
}
