#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QNetworkAccessManager>
#include <QMutex>

class NetworkManager
{
public:
    static NetworkManager* instance();
    QNetworkReply* get(const QNetworkRequest& request);
private:
    NetworkManager();
    ~NetworkManager();

    Q_DISABLE_COPY(NetworkManager)
private:
    QNetworkAccessManager *manager;
    static QMutex mutex;
};

#endif
