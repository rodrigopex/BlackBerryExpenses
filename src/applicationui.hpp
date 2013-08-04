#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <QVariantMap>
#include <bb/system/InvokeManager>
#include <bb/system/CardDoneMessage>

namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;
    }
}

class QTranslator;

/*!
 * @brief Application object
 *
 *
 */

class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() { }
    Q_INVOKABLE QVariantMap contactDetails(int contactId);
    Q_INVOKABLE void invokeCamera();
Q_SIGNALS:
    	void newReceiptPhoto(QString path);
public slots:
	void cameraDone(const bb::system::CardDoneMessage & msg);
private slots:
    void onSystemLanguageChanged();
private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;
    bb::system::InvokeManager* m_invocationManager;
};

#endif /* ApplicationUI_HPP_ */
