#ifndef AUDIODATA_H
#define AUDIODATA_H

#include <QObject>

#include <QUrl>

class AudioData : public QObject
{
    Q_OBJECT
public:
    enum SUPPORTS {
        MP3,
        FLAC
    };

public:
    explicit AudioData(QObject *parent = 0);

public slots:
    void addFile(const QString& url);
    void addFiles(const QStringList& urls);
    void addFiles(const QList<QUrl>& urls);
signals:
    void parseFinished(const QString &json);
public slots:

};

#endif // AUDIODATA_H
