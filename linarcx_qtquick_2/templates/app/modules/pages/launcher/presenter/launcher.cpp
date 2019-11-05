#include <QDebug>
#include <QSettings>
#include <QString>
#include <QVariant>
#include <iostream>

#include "modules/core/dispatcher/dispatcher.h"
#include "modules/core/dispatcher/dispatcherMacro.h"
#include "modules/pages/launcher/presenter/launcher.h"

#include "util/cpp/ConvertUtil.h"
#include "util/cpp/FileUtil.h"
#include "util/cpp/QtUtil.h"

using namespace std;

Launcher::Launcher(QObject* parent)
{
}

void Launcher::getAllKeys()
{
    QStringList keys = QtUtil::getAllKeys(ORGANIZATION, APPLICATION, TEMPLATES_GROUP);
    emit allKeysReady(keys);
}

void Launcher::clearCache()
{
    Dispatcher::getEngine()->trimComponentCache();
    Dispatcher::getEngine()->clearComponentCache();
    Dispatcher::getEngine()->trimComponentCache();
    emit cacheCleared();
}

void Launcher::removeItem(QVariant key)
{
    QtUtil::removeKey(ORGANIZATION, APPLICATION, TEMPLATES_GROUP, key.toString());
}

void Launcher::listTemplates(QVariant rawPath)
{
    QStringList templates;
    bool templatesDirExists = FileUtil::dirExists(rawPath.toString().split("//")[1] + "/templates");
    if (templatesDirExists) {
        templates = FileUtil::directoryList(rawPath.toString().split("//")[1] + "/templates");
        emit templatesReady(templates);
    } else {
        emit templatesReady(*new QStringList());
    }
}

void Launcher::savePath(QVariant key, QVariant rawPath)
{
    QtUtil::setKeyValue(ORGANIZATION, APPLICATION, TEMPLATES_GROUP, key.toString(), rawPath.toString());
}
