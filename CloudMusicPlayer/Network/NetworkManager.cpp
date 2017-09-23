#include "NetworkManager.h"

QMutex NetworkManager::mutex;
NetworkManager *NetworkManager::instance()
{
    QMutexLocker locker(&mutex);
    static NetworkManager _instance;
    return &_instance;
}

QNetworkReply *NetworkManager::get(const QNetworkRequest &request)
{
    return manager->get(request);
}

NetworkManager::NetworkManager() : manager(new QNetworkAccessManager())
{
}

NetworkManager::~NetworkManager()
{
    delete manager;
    manager = Q_NULLPTR;
}
