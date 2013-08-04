#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include <bb/cascades/Pickers/ContactPicker>
#include <bb/cascades/Pickers/ContactSelectionMode>

#include <bb/pim/contacts/ContactService>
#include <bb/pim/contacts/Contact>

#include <bb/system/InvokeTargetReply>
#include <bb/system/InvokeRequest>

#include <bb/cascades/Page>

using namespace bb::cascades;
using namespace bb::pim;
using namespace bb::system;
using namespace bb::cascades::pickers;
using namespace bb::pim::contacts;



ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app)
{

	// prepare the localization
	qmlRegisterType<ContactPicker>("bb.cascades.pickers", 1, 0,
				"ContactPicker");
	qmlRegisterUncreatableType<ContactSelectionMode>("bb.cascades.pickers", 1,
				0, "ContactSelectionMode", "");

    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
    if(!QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()))) {
        // This is an abnormal situation! Something went wrong!
        // Add own code to recover here
        qWarning() << "Recovering from a failed connect()";
    }
    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("controller", this);
    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("BlackBerryExpenses_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

QVariantMap ApplicationUI::contactDetails(int contactId) {
	QVariantMap ret;
	Contact contact = ContactService().contactDetails(contactId);
	qDebug() << qPrintable(contact.displayName());
	qDebug() << qPrintable(contact.primaryPhoto().largePhoto());
	ret["name"] = QVariant(contact.displayName());
	ret["imageSouce"] = QVariant(contact.primaryPhoto().largePhoto());
	return ret;
}

void ApplicationUI::invokeCamera() {
	if (!m_invocationManager)
		m_invocationManager = new InvokeManager();
	InvokeRequest cardRequest;
	cardRequest.setTarget("sys.camera.card");
	cardRequest.setAction("bb.action.CAPTURE");
	cardRequest.setData("photo");
	InvokeTargetReply * reply = m_invocationManager->invoke(cardRequest);
	reply->setParent(this);
	connect(m_invocationManager,
			SIGNAL(childCardDone(const bb::system::CardDoneMessage &)), this,
			SLOT(cameraDone(const bb::system::CardDoneMessage &)));
}

void ApplicationUI::cameraDone(const bb::system::CardDoneMessage & msg) {
//	qDebug() << msg.data();
	emit this->newReceiptPhoto(msg.data());
}
