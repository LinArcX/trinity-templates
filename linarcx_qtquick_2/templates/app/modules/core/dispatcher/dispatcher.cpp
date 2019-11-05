#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "dispatcher.h"
#include "modules/pages/launcher/presenter/launcher.h"
#include "modules/pages/settings/presenter/settings.h"

Dispatcher::Dispatcher(QGuiApplication& app, bool& isRTL, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    app.setOrganizationName("linarcx");
    app.setOrganizationDomain("io.github.com");
    app.setApplicationName("{[PROJECT_NAME]}");

    registerTypes();

    getContext()->setContextProperty(IS_RTL, isRTL);
    getContext()->setContextProperty(DISPATCHER, this);
    getContext()->setContextProperty(APP, &app);
    getContext()->setContextProperty(ENGINE, getEngine());

    getEngine()->load(QUrl(QLatin1String(MAIN_QML)));
}

Dispatcher::~Dispatcher()
{
}

void Dispatcher::clearCache()
{
    getEngine()->trimComponentCache();
    getEngine()->clearComponentCache();
    getEngine()->trimComponentCache();
    emit cacheCleared();
}

void Dispatcher::registerTypes()
{
    qmlRegisterType<Launcher>("LauncherClass", 1, 0, "LauncherClass");
    qmlRegisterType<Settings>("SettingsClass", 1, 0, "SettingsClass");
}
