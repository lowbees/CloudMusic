#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "AudioData/audiodata.h"
#include "FramelessHelper/framelesswindowhelper.h"
#include <QtAV>
#include <QtAVWidgets>

class PathGetter : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString getCurrentPath()
    {
        return QCoreApplication::applicationDirPath();
    }
};
#include "main.moc"
int main(int argc, char *argv[])
{
    QtAV::Widgets::registerRenderers();
    QGuiApplication app(argc, argv);

    PathGetter getter;
    qmlRegisterType<AudioData>("AudioData", 1, 0, "AudioData");
    qmlRegisterType<FramelessWindowHelper>("FramelessWindowHelper", 1, 0, "FramelessWindowHelper");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("pathGetter", &getter);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
