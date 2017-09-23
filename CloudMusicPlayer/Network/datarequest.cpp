#include "datarequest.h"
#include "NetworkManager.h"
#include <QNetworkReply>
#include <QNetworkRequest>

DataRequest::DataRequest(QObject *parent) : QObject(parent)
{

}

void DataRequest::get(const QString &path)
{
    QUrl url("http://localhost:3000" + path);
    if (url.isValid()) {
        auto reply = NetworkManager::instance()->get(QNetworkRequest(url));
        connect(reply, SIGNAL(finished()), this, SLOT(readFinished()));
    }
}



void DataRequest::get(const QUrl &url)
{
    if (url.isValid()) {
        auto reply = NetworkManager::instance()->get(QNetworkRequest(url));
        connect(reply, SIGNAL(finished()), this, SLOT(readFinished()));
    }
}

void DataRequest::readFinished()
{
    auto reply = qobject_cast<QNetworkReply*>(sender());
    if (reply) {
        reply->deleteLater();
        emit finished(reply->readAll(), reply->url().path());
    }
}
