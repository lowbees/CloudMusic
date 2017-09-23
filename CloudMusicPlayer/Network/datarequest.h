#ifndef DATAREQUEST_H
#define DATAREQUEST_H

#include <QObject>
#include <QUrl>

class DataRequest : public QObject
{
    Q_OBJECT
public:
    explicit DataRequest(QObject *parent = 0);


signals:
    void finished(const QString& json, const QString& pathName);

public slots:
    void get(const QString& path);

    void get(const QUrl& url);
    void readFinished();
};

#endif // DATAREQUEST_H
